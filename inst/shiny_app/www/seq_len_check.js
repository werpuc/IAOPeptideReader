Shiny.addCustomMessageHandler("seq_len_check", function(is_ok) {
    var seq_len_input = document.getElementById("sequence_length");

    if (is_ok) {
        seq_len_input.removeAttribute("is_wrong");
    } else {
        seq_len_input.setAttribute("is_wrong", "");
    }
});
