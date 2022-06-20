public with sharing class PizzaCostCalculator {

    private Integer ONLY_ONE_SLICE;
    private Integer UP_TO_THREE_SLICES;
    private Integer MORE_THAN_THREE_SLICES;

//    public PizzaCostCalculator(Integer ONLY_ONE_SLICE_INPUT, Integer UP_TO_THREE_SLICES_INPUT, Integer MORE_THAN_THREE_SLICES_INPUT) {
//        this.ONLY_ONE_SLICE = ONLY_ONE_SLICE_INPUT;
//        this.UP_TO_THREE_SLICES = UP_TO_THREE_SLICES_INPUT;
//        this.MORE_THAN_THREE_SLICES =MORE_THAN_THREE_SLICES_INPUT;
//    }

    public void setSlicePrices(Integer ONLY_ONE_SLICE_INPUT, Integer UP_TO_THREE_SLICES_INPUT, Integer MORE_THAN_THREE_SLICES_INPUT){
        ONLY_ONE_SLICE = ONLY_ONE_SLICE_INPUT;
        UP_TO_THREE_SLICES = UP_TO_THREE_SLICES_INPUT;
        MORE_THAN_THREE_SLICES = MORE_THAN_THREE_SLICES_INPUT;
    }

    public void setNumberOfSlicesPerClient(Map<String,Integer> clientsSlicesMap) {
        Integer price;
        for (String clientSlice : clientsSlicesMap.keySet()) {

            Integer sliceNumber = clientsSlicesMap.get(clientSlice);
            if (sliceNumber == 1) {
                price = ONLY_ONE_SLICE;
            } else if(sliceNumber<=3){
                price = UP_TO_THREE_SLICES*clientsSlicesMap.get(clientSlice);
            } else if(sliceNumber>3){
                price = MORE_THAN_THREE_SLICES*clientsSlicesMap.get(clientSlice);
            }
            System.debug('Client '+clientSlice+' has ordered '+clientsSlicesMap.get(clientSlice)+' slices. He/She pays '+price+' DOLLARS');
        }
    }
}