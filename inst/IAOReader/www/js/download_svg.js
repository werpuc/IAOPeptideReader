// Reference: https://stackoverflow.com/a/37387449

function download_svg_node(svg_node){
    // svg_min contains only relevant styles carried over.
    var svg_min = svg_node.cloneNode(true);
    copy_style(svg_min, svg_node);

    // Creating SVG download URL.
    var svg_string = new XMLSerializer().serializeToString(svg_min);
    var svg_blob = new Blob([svg_string], {type: "image/svg+xml;charset=utf-8"});
    var svg_url = URL.createObjectURL(svg_blob);

    // Creating an a tag object for downloading the SVG and starting download.
    var svg_link = document.createElement("a");
    svg_link.href = svg_url;
    svg_link.download = "Peptide_Coverage_Plot.svg";
    svg_link.click();
    svg_link.remove()
}


function copy_style(dest, src) {
    var dest_children = dest.childNodes,
        src_children = src.childNodes;

    for (var i = 0; i < dest_children.length; i++) {
        var dest_child = dest_children[i],
            src_child = src_children[i],
            dest_tag_name = dest_child.tagName;

        // If current tag is container then descend recursively.
        if (container_elements.indexOf(dest_tag_name) != -1) {
            copy_style(dest_child, src_child);
        }

        // If tag is a one which should have style carried over then proceed to
        // copying the style.
        if (dest_tag_name in relevant_styles) {
            var src_style = window.getComputedStyle(src_child),
                style_string = "", current_style, current_style_val;

            // Copy every relevant style for given tag name.
            for (var j = 0; j < relevant_styles[dest_tag_name].length; j++) {
                current_style = relevant_styles[dest_tag_name][j];
                current_style_val = src_style.getPropertyValue(current_style);

                style_string += current_style + ":" + current_style_val + ";";
            }

            // Apply created style_string to the destination element.
            dest_child.setAttribute("style", style_string);

            // Removing hidden elements to avoid them being shown in SVG editors.
            // Doing it at the end to avoid messing the structure up.
            if (window.getComputedStyle(src_child)["visibility"] === "hidden") {
                dest_child.remove();
            }
        }
    }
}


var container_elements = ["svg", "g"];
var relevant_styles = {
    "rect": ["fill", "stroke", "stroke-width", "filter", "opacity"],
    "path": ["fill", "stroke", "stroke-width"],
    "line": ["stroke", "stroke-width"],
    "text": ["fill", "font-size", "text-anchor", "font-family"]
};
