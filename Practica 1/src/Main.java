import IA.Azamon.Paquetes;
import IA.Azamon.Transporte;
import aima.search.framework.Problem;
import aima.search.framework.Search;
import aima.search.framework.SearchAgent;
import aima.search.informed.HillClimbingSearch;
import aima.search.informed.SimulatedAnnealingSearch;

import java.util.*;

public class Main {
    public static void main(String[] args) {
        // TODO tomar npaq, proportion por consola
        Random rand = new Random();
        int npaq = 10;
        int seedPaq = rand.nextInt(npaq);
        Paquetes paq = new Paquetes(npaq, seedPaq);

        double proportion = 4;
        int seedTransport = rand.nextInt((int) Math.round(proportion));

        Transporte transport = new Transporte(paq, proportion, seedTransport);

        AzamonInitialSolution initialSolution = new AzamonInitialSolution();
        ArrayList<Integer> assignment = initialSolution.randomSolution(transport, paq);

        AzamonBoard AB = new AzamonBoard(assignment, transport, paq);

        TSPHillClimbingSearch(AB);
        TSPSimulatedAnnealingSearch(AB);
    }

    private static void TSPHillClimbingSearch(AzamonBoard AB) {
        System.out.println("\nTSP HillClimbing  -->");

        try {
            Problem problem = new Problem(AB, new AzamonSuccessorFunctionHC(), new AzamonGoalTest(), new AzamonHeuristicFunction());
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

    private static void TSPSimulatedAnnealingSearch(AzamonBoard AB) {
        System.out.println("\nTSP Simulated Annealing  -->");

        try {
            Problem problem = new Problem(AB, new AzamonSuccessorFunctionSA(), new AzamonGoalTest(), new AzamonHeuristicFunction());
            SimulatedAnnealingSearch search = new SimulatedAnnealingSearch(2000, 100, 5, 0.001);
            SearchAgent agent = new SearchAgent(problem, search);
            System.out.println();
            printActions(agent.getActions());
            printInstrumentation(agent.getInstrumentation());
        } catch (Exception var4) {
            Exception e = var4;
            e.printStackTrace();
        }

    }

    private static void printInstrumentation(Properties properties) {
        for (Object o : properties.keySet()) {
            String key = (String) o;
            String property = properties.getProperty(key);
            System.out.println(key + " : " + property);
        }
    }

    private static void printActions(List actions) {
        for (Object o : actions) {
            String action = (String) o;
            System.out.println(action);
        }
    }
}
