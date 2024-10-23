import aima.search.framework.Successor;
import aima.search.framework.SuccessorFunction;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class AzamonSuccessorFunctionHC implements SuccessorFunction {
    Operation operation;

    public AzamonSuccessorFunctionHC(Operation operation) {
        this.operation = operation;
    }

    public List<Successor> getSuccessors(Object aState) {
        List<Successor> retVal = new ArrayList<>();
        AzamonBoard board  = (AzamonBoard) aState;

        AzamonHeuristicFunction AHF = new AzamonHeuristicFunction();
        Random rand = new Random();
        for (int i = 0; i <  board.getN_packets(); i++) {
            for (int j = 0; j < board.getN_offers(); j++) {
                Util.executeOperator(board, operation, i, j, rand, AHF, retVal);
            }
        }
        return retVal;
    }
}