import aima.search.framework.Successor;
import aima.search.framework.SuccessorFunction;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class AzamonSuccessorFunctionSA implements SuccessorFunction {
    Operation operation;

    public AzamonSuccessorFunctionSA(Operation operation) {
        this.operation = operation;
    }

    public List<Successor> getSuccessors(Object aState) {
        List<Successor> retVal = new ArrayList<>();
        AzamonBoard board  = (AzamonBoard) aState;
        AzamonHeuristicFunction AHF = new AzamonHeuristicFunction();
        int i,j;
        Random rand = new Random();



        AzamonBoard newBoard = new AzamonBoard(board.getAssignment(), board.getTrans(), board.getPakgs(), board.getHappiness());
        String S = "";
        switch (operation) {
            case MOVE: {
                i=rand.nextInt(board.getN_packets());
                j=rand.nextInt(board.getN_offers());
                newBoard.move(i,j);
                double v = AHF.getHeuristicValue(newBoard);
                S = "Move packet(" + i + ") to offer (" + j + ") Cost =" + v + ") ---> " + newBoard.toString();
                break;
            }
            case MOVE_AND_SWAP: {
                int op = rand.nextInt(1);
                if (op == 0) {
                    i = rand.nextInt(board.getN_packets());
                    j = rand.nextInt(board.getN_offers());
                    newBoard.move(i, j);
                    double v = AHF.getHeuristicValue(newBoard);
                    S = "Move packet(" + i + ") to offer (" + j + ") Cost =" + v + ") ---> " + newBoard.toString();
                }
                else {
                    i = rand.nextInt(board.getN_packets());
                    j = rand.nextInt(board.getN_packets());
                    newBoard.swap(i, j);
                    double v = AHF.getHeuristicValue(newBoard);
                    S = "Swap packet(" + i + ") with packet (" + j + ") Cost =" + v + ") ---> " + newBoard.toString();
                }
                break;
            }
            case MOVE_AND_POUR: {
                int op = rand.nextInt(1);
                if (op == 0) {
                    i = rand.nextInt(board.getN_packets());
                    j = rand.nextInt(board.getN_offers());
                    newBoard.move(i, j);
                    double v = AHF.getHeuristicValue(newBoard);
                    S = "Move packet(" + i + ") to offer (" + j + ") Cost =" + v + ") ---> " + newBoard.toString();
                }
                else {
                    i = rand.nextInt(board.getN_offers());
                    newBoard.pour(i);
                    double v = AHF.getHeuristicValue(newBoard);
                    S = "Pour offer(" + i + ") Cost =" + v + ") ---> " + newBoard.toString();
                }
                break;
            }
            case MOVE_SWAP_AND_POUR: {
                int op = rand.nextInt(2);
                if (op == 0) {
                    i = rand.nextInt(board.getN_packets());
                    j = rand.nextInt(board.getN_offers());
                    newBoard.move(i, j);
                    double v = AHF.getHeuristicValue(newBoard);
                    S = "Move packet(" + i + ") to offer (" + j + ") Cost =" + v + ") ---> " + newBoard.toString();
                    break;
                }
                else if (op == 1) {
                    i = rand.nextInt(board.getN_packets());
                    j = rand.nextInt(board.getN_packets());
                    newBoard.swap(i, j);
                    double v = AHF.getHeuristicValue(newBoard);
                    S = "Swap packet(" + i + ") with packet (" + j + ") Cost =" + v + ") ---> " + newBoard.toString();
                }
                else if (op == 2) {
                    i = rand.nextInt(board.getN_offers());
                    newBoard.pour(i);
                    double v = AHF.getHeuristicValue(newBoard);
                    S = "Pour offer(" + i + ") Cost =" + v + ") ---> " + newBoard.toString();
                }
                break;
            }
            default: {  // Move
                i = rand.nextInt(board.getN_packets());
                j = rand.nextInt(board.getN_offers());
                newBoard.move(i,j);
                double v = AHF.getHeuristicValue(newBoard);
                S = "Move packet(" + i + ") to offer (" + j + ") Cost =" + v + ") ---> " + newBoard.toString();
                break;
            }
        }

        retVal.add(new Successor(S, newBoard));
        return retVal;
    }
}
