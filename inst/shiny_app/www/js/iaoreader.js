let IAOReader = class {
    width = 1280;
    height = 720;
    margin = 30;

    get svg() {
        return d3.select("div#plot svg");
    }

    // Note: this has to be called manually due to the script being invoked
    //       before the full HTML creation. Calling update_svg in constructor
    //       has no effect due to the svg not being created yet.
    update_svg() {
        // TODO: remove redundant parameters
        this.svg
            .attr("_x", this.width)
            .attr("_y", this.height)
            .attr("_margin", this.margin)
            .attr("viewBox", "0 0 " + this.width + " " + this.height);
    }
}

var iaoreader = new IAOReader();
