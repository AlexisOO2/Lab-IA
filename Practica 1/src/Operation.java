public enum Operation {
    MOVE(1),
    MOVE_AND_SWAP(2),
    MOVE_AND_POUR(3),
    MOVE_SWAP_AND_POUR(4),
    MOVE_SWAP_OFFERS(5),
    MOVE_SWAP_SWAP_OFFERS(6);

    private final int value;

    Operation(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }

    public static Operation fromInt(int value) {
        for (Operation op : Operation.values()) {
            if (op.getValue() == value) {
                return op;
            }
        }
        throw new IllegalArgumentException("Invalid value: " + value);
    }
}
