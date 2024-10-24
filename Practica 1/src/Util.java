import aima.search.framework.Successor;

import java.util.List;
import java.util.Random;

public class Util {
    public static void executeOperator(AzamonBoard board, Operation operation, Random rand, AzamonHeuristicFunction AHF, List<Successor> retVal) {
        int i,j;
        AzamonBoard newBoard = new AzamonBoard(board.getAssignment(), board.getTrans(), board.getPakgs(), board.getHappiness());
        String S = "";
        switch (operation) {
            case MOVE: {
                i=rand.nextInt(board.getN_packets());
                j=rand.nextInt(board.getN_offers());
                newBoard.move(i,j);
                double v = AHF.getHeuristicValue(newBoard);
                S = "Move packet(" + i + ") to offer (" + j + ") Cost =" + v + ") ---> " + newBoard;
                break;
            }
            case MOVE_AND_SWAP: {
                int op = rand.nextInt(2);
                if (op == 0) {
                    S = move(board, rand, AHF, newBoard);
                }
                else {
                    i = rand.nextInt(board.getN_packets());
                    j = rand.nextInt(board.getN_packets());
                    newBoard.swap(i, j);
                    double v = AHF.getHeuristicValue(newBoard);
                    S = "Swap packet(" + i + ") with packet (" + j + ") Cost =" + v + ") ---> " + newBoard;
                }
                break;
            }
            case MOVE_AND_POUR: {
                int op = rand.nextInt(2);
                if (op == 0) {
                    S = move(board, rand, AHF, newBoard);
                }
                else {
                    i = rand.nextInt(board.getN_offers());
                    newBoard.pour(i);
                    double v = AHF.getHeuristicValue(newBoard);
                    S = "Pour offer(" + i + ") Cost =" + v + ") ---> " + newBoard;
                }
                break;
            }
            case MOVE_SWAP_AND_POUR: {
                int op = rand.nextInt(4);
                if (op == 0) {
                    S = move(board, rand, AHF, newBoard);
                    break;
                }
                else if (op == 1) {
                    i = rand.nextInt(board.getN_packets());
                    j = rand.nextInt(board.getN_packets());
                    newBoard.swap(i, j);
                    double v = AHF.getHeuristicValue(newBoard);
                    S = "Swap packet(" + i + ") with packet (" + j + ") Cost =" + v + ") ---> " + newBoard;
                }
                else if (op == 2) {
                    i = rand.nextInt(board.getN_offers());
                    newBoard.pour(i);
                    double v = AHF.getHeuristicValue(newBoard);
                    S = "Pour offer(" + i + ") Cost =" + v + ") ---> " + newBoard;
                }
                break;
            }
            case MOVE_SWAP_OFFERS: {
                int op = rand.nextInt(3);
                if (op == 0) {
                    S = move(board, rand, AHF, newBoard);
                    break;
                }
                else if (op == 1) {
                    i = rand.nextInt(board.getN_offers());
                    j = rand.nextInt(board.getN_offers());
                    newBoard.swap_offers(i, j);
                    double v = AHF.getHeuristicValue(newBoard);
                    S = "Swap offer(" + i + ") with offer (" + j + ") Cost =" + v + ") ---> " + newBoard;
                }
                break;
            }
            case MOVE_SWAP_SWAP_OFFERS: {
                int op = rand.nextInt(4);
                if (op == 0) {
                    S = move(board, rand, AHF, newBoard);
                    break;
                }
                else if (op == 1) {
                    i = rand.nextInt(board.getN_packets());
                    j = rand.nextInt(board.getN_packets());
                    newBoard.swap(i, j);
                    double v = AHF.getHeuristicValue(newBoard);
                    S = "Swap packet(" + i + ") with packet (" + j + ") Cost =" + v + ") ---> " + newBoard;
                }
                else if (op == 2) {
                    i = rand.nextInt(board.getN_offers());
                    j = rand.nextInt(board.getN_offers());
                    newBoard.swap_offers(i, j);
                    double v = AHF.getHeuristicValue(newBoard);
                    S = "Swap offer(" + i + ") with offer (" + j + ") Cost =" + v + ") ---> " + newBoard;
                }
                break;
            }
            default: {  // Move
                S = move(board, rand, AHF, newBoard);
                break;
            }
        }
        retVal.add(new Successor(S, newBoard));
    }

    private static String move(AzamonBoard board, Random rand, AzamonHeuristicFunction AHF, AzamonBoard newBoard) {
        int i;
        int j;
        String S;
        i = rand.nextInt(board.getN_packets());
        j = rand.nextInt(board.getN_offers());
        newBoard.move(i,j);
        double v = AHF.getHeuristicValue(newBoard);
        S = "Move packet(" + i + ") to offer (" + j + ") Cost =" + v + ") ---> " + newBoard;
        return S;
    }
}
