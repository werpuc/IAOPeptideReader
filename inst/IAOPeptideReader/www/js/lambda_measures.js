// data: an Array of {Start: x1, End: x2} JSON objects.
// n0: point for which the value will be calculated.
// k: the penalty parameter.
function lambda(data, n0, k) {
    return lambda_segment(data, n0, n0, k)
}


// data: an Array of {Start: x1, End: x2} JSON objects.
// n1: left-hand side end of the segment of interest.
// n2: right-hand side end of the segment of interest.
// k: the penalty parameter.
function lambda_segment(data, n1, n2, k) {
    var nomin = 0, denom = 0;

    data.forEach(function(d) {
        if (d.Start <= n1 && n2 <= d.End) {
            denom++;

            if (d.Start <= n1 - k && n2 + k <= d.End) {
                nomin++;
            }
        }
    });

    return nomin / denom;
}
