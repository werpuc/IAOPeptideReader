// <ToDo: description>
Shiny.addCustomMessageHandler('background-color', function(data) {
    document.body.style.backgroundColor = data.color;
});
