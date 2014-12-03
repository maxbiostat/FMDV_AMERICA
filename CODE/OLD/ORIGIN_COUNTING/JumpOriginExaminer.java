package dr.app.tools;

import dr.evolution.io.Importer;
import dr.evolution.io.NexusImporter;
import dr.evolution.tree.FlexibleNode;
import dr.evolution.tree.FlexibleTree;

import java.io.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;

/**
 * Created with IntelliJ IDEA.
 * User: mhall
 * Date: 18/03/2013
 * Time: 13:11
 * To change this template use File | Settings | File Templates.
 */
public class JumpOriginExaminer {

    private FlexibleTree[] trees;
    private String[] taxa;
    private String[] traits;
    private int index;
    private String divider;
    private String attributeName;
    private String fileNameRoot;

    private JumpOriginExaminer(String[] taxa, int index, String divider, FlexibleTree[] trees,
                               String attributeName, String fileNameRoot){
        this.taxa=taxa;
        this.index = index;
        this.divider = divider;
        traits = getTraits();
        this.trees = trees;
        this.attributeName = attributeName;
        this.fileNameRoot = fileNameRoot;
    }


    private FlexibleNode findCommonAncestor(FlexibleTree tree, FlexibleNode[] nodes){
        HashSet<FlexibleNode> doneNodes = new HashSet<FlexibleNode>();
        FlexibleNode currentParent = nodes[0];
        for(FlexibleNode node: nodes){
            doneNodes.add(node);
            boolean ancestorOfAllDoneNodes = false;
            currentParent = node;
            if(getTipSet(tree, currentParent).containsAll(doneNodes)){
                ancestorOfAllDoneNodes=true;
            }
            while(!ancestorOfAllDoneNodes){
                currentParent = (FlexibleNode)tree.getParent(currentParent);
                if(getTipSet(tree, currentParent).containsAll(doneNodes)){
                    ancestorOfAllDoneNodes=true;
                }
            }
        }
        return currentParent;
    }


    private boolean branchNode(FlexibleTree tree, FlexibleNode node){
        return tree.getChildCount(node)==2;
    }

    private String[] getTraits(){
        HashSet<String> tempSet = new HashSet<String>();
        for(String taxon: taxa){
            String[] splitTaxon = taxon.split(divider);
            tempSet.add(splitTaxon[index]);
        }
        return tempSet.toArray(new String[tempSet.size()]);
    }

    private String[] getAssociatedTaxa(String trait){
        HashSet<String> tempSet = new HashSet<String>();
        for(String taxon: taxa){
            if(taxon.split(divider)[index].equals(trait)){
                tempSet.add(taxon);
            }
        }
        return tempSet.toArray(new String[tempSet.size()]);
    }

    private FlexibleNode[] getAssociatedChildren(FlexibleTree tree, String trait){
        HashSet<FlexibleNode> tempSet = new HashSet<FlexibleNode>();
        String[] taxa = getAssociatedTaxa(trait);
        for(String taxon: taxa){
            for(int i=0; i<tree.getExternalNodeCount(); i++){
                if(tree.getNodeTaxon(tree.getExternalNode(i)).toString().equals(taxon)){
                    tempSet.add((FlexibleNode)tree.getExternalNode(i));
                }
            }
        }
        return tempSet.toArray(new FlexibleNode[tempSet.size()]);
    }

    private HashMap<String,String> getIncomingJumpOrigins(FlexibleTree tree){
        HashMap<String,String> out = new HashMap<String, String>();
        for(String trait: traits){
            FlexibleNode[] traitTaxa = getAssociatedChildren(tree, trait);
            FlexibleNode mrca = findCommonAncestor(tree, traitTaxa);
            HashSet<FlexibleNode> taxaSet = new HashSet<FlexibleNode>(Arrays.asList(traitTaxa));
            HashSet<FlexibleNode> tipSet = getTipSet(tree, mrca);
            if(!taxaSet.containsAll(tipSet)){
                System.out.println("WARNING: mixed traits in a clade");
            }
            if(!mrca.getAttribute(attributeName).equals("\""+trait+"\"")){
                out.put(trait,"Multiple");
                System.out.println("Multiple origin found.");
            } else {
                boolean sameTrait = true;
                FlexibleNode currentParent = mrca;
                while(sameTrait){
                    currentParent = (FlexibleNode)tree.getParent(currentParent);
                    if(currentParent==null){
                        out.put(trait,"root");
                        break;
                    } else {
                        String parentTrait = (String)currentParent.getAttribute(attributeName);
                        parentTrait = parentTrait.replaceAll("\"","");
                        if(!parentTrait.equals(trait)){
                            sameTrait = false;
                            out.put(trait,parentTrait);
                        }
                    }
                }
            }

        }
        return out;
    }


    private HashSet<FlexibleNode> getTipSet(FlexibleTree tree, FlexibleNode node){
        HashSet<FlexibleNode> out = new HashSet<FlexibleNode>();
        if(tree.isExternal(node)){
            out.add(node);
            return out;
        } else {
            for(int i=0; i<tree.getChildCount(node); i++){
                out.addAll(getTipSet(tree, (FlexibleNode)tree.getChild(node, i)));
            }
        }
        return out;
    }

    private void tabulateOrigins(){

        HashMap<String,HashMap<String,Integer>> bigMap = new HashMap<String, HashMap<String, Integer>>();
        for(String destination: traits){
            bigMap.put(destination, new HashMap<String,Integer>());
        }
        int count = 0;
        for(FlexibleTree currentTree: trees){
            if(count % 1 == 0){
                System.out.println("Doing tree "+count);
            }
            HashMap<String,String> results = getIncomingJumpOrigins(currentTree);
            for(String key: results.keySet()){
                HashMap<String,Integer> traitMap = bigMap.get(key);
                String thisResult = results.get(key);
                int oldCount = traitMap.containsKey(results.get(key)) ? traitMap.get(results.get(key)) : 0;
                traitMap.put(results.get(key), oldCount+1);
            }
            count++;
        }

        try{
            for(String trait: traits){
                BufferedWriter outWriter = new BufferedWriter(new FileWriter(fileNameRoot+trait+".csv"));
                outWriter.write(trait+"\n");
                for(String key: bigMap.get(trait).keySet()){
                    outWriter.write(key+","+bigMap.get(trait).get(key)+"\n");
                }
                outWriter.flush();
            }
        } catch(IOException e){
            System.out.println("Failed to write to file");
        }
    }


    public static void main(String[] args){
        try{
            BufferedReader taxonReader = new BufferedReader(new FileReader("/Users/mhall/Documents/FMD global/VP1/Type SAT 2 VP1/epidemic_taxa.txt"));
            HashSet<String> tempTaxa = new HashSet<String>();
            String line;
            while((line = taxonReader.readLine())!=null){
                tempTaxa.add(line);
            }
            String[] taxa = tempTaxa.toArray(new String[tempTaxa.size()]);

            NexusImporter importer = new NexusImporter(new FileReader("/Users/mhall/Documents/FMD global/VP1/Type SAT 2 VP1/Final rush/SAT2_VP1_250_countries_asym_emptrees_MJ/SAT2_VP1_250_countries_asym_emptrees_MJ_combined.fancytrees.txt"));
            importer.setSuppressWarnings(true);
            ArrayList<FlexibleTree> tempTrees = new ArrayList<FlexibleTree>();
            int count = 0;
            while(importer.hasTree()){
                if(count % 100 == 0){
                    System.out.println("Loaded "+count+" trees");
                }
                tempTrees.add((FlexibleTree)importer.importNextTree());
                count++;
            }
            FlexibleTree[] trees = tempTrees.toArray(new FlexibleTree[tempTrees.size()]);
            JumpOriginExaminer examiner = new JumpOriginExaminer(taxa,2,"\\|",trees,"Country",
                    "/Users/mhall/Documents/FMD global/VP1/Type SAT 2 VP1/Final rush/SAT2_VP1_250_countries_asym_emptrees_MJ/SAT2_VP1_250_countries_asym_emptrees_MJ_");
            examiner.tabulateOrigins();
        } catch(IOException e){
            System.out.println("Failed to read files");
        } catch(Importer.ImportException e){
            System.out.println("Failed to import trees");
        }
    }


}
