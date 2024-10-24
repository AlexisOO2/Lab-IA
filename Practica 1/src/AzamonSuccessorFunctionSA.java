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
        Random rand = new Random();
        Util.executeOperator(board, operation, rand, AHF, retVal);
        return retVal;
    }
}
