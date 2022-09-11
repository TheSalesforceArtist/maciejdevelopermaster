
({
    startGame: function (component, event, helper) {
            // access combobox
            let gameModeComboBox = component.find("gameMode");

            //access the value of combobox
            let selectedValue = gameModeComboBox.get("v.value");
            console.log("The start new game button is clicked. The game mode is: "+selectedValue);
            alert("The start new game button is clicked. The game mode is: "+selectedValue);

            //update the selected mode attribute
            component.set("v.selectedMode", selectedValue);
            console.log("the selected value is "+component.get("selectedValue"))
        },
    reshuffleBoard: function (component, event, helper){
            console.log("the reshuffle buttion is clicked");
    }
});