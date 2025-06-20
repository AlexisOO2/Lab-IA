import IA.Azamon.Paquetes;
import IA.Azamon.Transporte;
import aima.search.framework.Problem;
import aima.search.framework.Search;
import aima.search.framework.SearchAgent;
import aima.search.informed.HillClimbingSearch;
import aima.search.informed.SimulatedAnnealingSearch;

import java.util.*;

public class Main {
    static int algorithm;
    static int k;
    static double lambda;
    static int nPackages;
    static int heuristic;
    static int InitialStateGenerator;
    static double proportion;
    static Operation operation;

    public static void main(String[] args) {
        /*
        // Default values:
             k = 5;
             lambda = 0.001;
             npaq = 10;
             proportion = 4;
             operation = Operation.MOVE;
         */

        getVariablesFromCommandLine();
        Random rand = new Random();

        int seed = 1234;
        Paquetes paq = new Paquetes(nPackages, seed);

        Transporte transport = new Transporte(paq, proportion, seed);

        ArrayList<Integer> assignment = getInitialState(transport, paq);

        AzamonBoard AB = new AzamonBoard(assignment, transport, paq, heuristic);

        long startTime = System.currentTimeMillis();
        if(algorithm == 1) TSPHillClimbingSearch(AB);
        else TSPSimulatedAnnealingSearch(AB, k, lambda);
        long endTime = System.currentTimeMillis();
        long duration = endTime - startTime;        // Calculate the duration in milliseconds
        System.out.println("Algorithm " + algorithm + " took " + duration + " milliseconds to run.");
    }

    private static void TSPHillClimbingSearch(AzamonBoard AB) {
        System.out.println("\nTSP HillClimbing  -->");

        try {
            Problem problem = new Problem(AB, new AzamonSuccessorFunctionHC(operation), new AzamonGoalTest(), new AzamonHeuristicFunction());
            Search search = new HillClimbingSearch();
            SearchAgent agent = new SearchAgent(problem, search);
            System.out.println();
            printActions(agent.getActions());
            printInstrumentation(agent.getInstrumentation());
        } catch (Exception var4) {
            Exception e = var4;
            e.printStackTrace();
        }
    }

    private static void TSPSimulatedAnnealingSearch(AzamonBoard AB, int k, double lambda) {
        System.out.println("\nTSP Simulated Annealing  -->");

        try {
            Problem problem = new Problem(AB, new AzamonSuccessorFunctionSA(operation), new AzamonGoalTest(), new AzamonHeuristicFunction());
            SimulatedAnnealingSearch search = new SimulatedAnnealingSearch(2000, 100, k, lambda);
            SearchAgent agent = new SearchAgent(problem, search);
            System.out.println();
            printActions(agent.getActions());
            printInstrumentation(agent.getInstrumentation());
        } catch (Exception var4) {
            Exception e = var4;
            e.printStackTrace();
        }

    }

    private static ArrayList<Integer> getInitialState(Transporte transport, Paquetes paq) {
        AzamonInitialSolution initialSolution = new AzamonInitialSolution();
        ArrayList<Integer> assignment;
        switch (InitialStateGenerator) {
            case 1: {
                assignment = initialSolution.capacityFirstSolution(transport, paq);
                break;
            }
            case 2:{
                assignment = initialSolution.priorityFirstSolution(transport, paq);
                break;
            }
            case 3:{
                assignment = initialSolution.randomSolution(transport, paq);
                break;
            }
            default:{
                assignment = initialSolution.randomSolution(transport, paq);
            }
            break;
        }
        return assignment;
    }

    private static void printInstrumentation(Properties properties) {
        for (Object o : properties.keySet()) {
            String key = o.toString();
            String property = properties.getProperty(key);
            System.out.println(key + " : " + property);
        }
    }

    private static void printActions(List actions) {
        for (Object o : actions) {
            String action = o.toString();
            System.out.println(action);
        }
    }

    private static void getVariablesFromCommandLine() {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Please enter a value for algorithm: \n1.Hill Climbing\n2.Simulated Annealing\n");
        algorithm = scanner.nextInt();

        if(algorithm == 2) {
            System.out.print("Please enter a value for k: ");
            k = scanner.nextInt();

            System.out.print("Please enter a value for lambda: ");
            lambda = scanner.nextDouble();
        }

        System.out.print("Please enter a value for number of packages: ");
        nPackages = scanner.nextInt();

        System.out.print("Please enter a value for proportion: ");
        proportion = scanner.nextDouble();

        System.out.print("Please enter a value for operation: \n1.Move\n2.Move and swap\n3.Move and pour\n4.Move, swap and pour\n5.Move and swap offers\n6.Move, swap and swap offers\n");
        int o = scanner.nextInt();
        operation = Operation.fromInt(o);

        System.out.print("Please enter a value to choose the Initial State generator function: \n1.Capacity First.\n2.Priority First.\n3.Random State\n");
        InitialStateGenerator = scanner.nextInt();

        System.out.print("Please enter a value to choose the heuristic function:\n1.Transportation Cost Only\n2.Transportation Cost + Happyness Index\n");
        heuristic = scanner.nextInt();
        heuristic -= 1;
        // Output the values entered
        // System.out.println("You entered k = " + k + " and lambda = " + lambda + " and nPackages = " + nPackages + " and proportion = " + proportion + " and operation = " + o);

        scanner.close();
    }
}
