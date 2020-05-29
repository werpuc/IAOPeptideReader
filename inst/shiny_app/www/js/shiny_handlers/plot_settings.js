// [[ Plot title ]]
Shiny.addCustomMessageHandler("plot_settings_title_text", function(title_text) {
    iaoreader.plot_settings.title.text(title_text);
});
