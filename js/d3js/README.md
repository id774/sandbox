# D3.js

D3 is not a chart library. It is a library for binding data to DOM elements and
computing the attributes those elements need — positions, widths, colours,
paths — leaving the drawing to SVG, HTML, and CSS. There is no `barChart()`
function; a bar chart is a `rect` per datum whose `height` you supply. The cost
is that every chart is written out; the benefit is that anything expressible in
SVG is reachable, which is why D3 remains the basis of most custom data
visualisation on the web.

The idea the whole library turns on is the data join. `selectAll(...)
.data(...) .enter() .append(...)` describes the elements that *should* exist
for a dataset, and D3 creates the ones that are missing. Almost every file in
this directory is a variation on that one sentence, which is what makes them
worth reading in sequence rather than individually.

These samples were written against the D3 3.x era and use its API:
`d3.scale.linear()`, `d3.layout.chord()`, and callback-style loaders
(`d3.csv(path, callback)`). D3 4 renamed the flat namespace
(`d3.scaleLinear()`), split the library into modules, and D3 5 moved the
loaders to promises — so none of these files run unchanged against a current
D3. They are kept as a record of what was tried.

## Layout

The samples build up in roughly this order.

| Directory | What it shows |
| --- | --- |
| `simple-d3` | The smallest possible case: `d3.select("body").append("p").text(...)`. |
| `data-binding` | The data join itself — an array of numbers becomes one `<p>` per element, with the colour decided by the value. |
| `bar-chart` | The same join producing `<div>` bars sized with CSS (`style.css`), before any SVG appears. |
| `bar-svg-chart` | The same chart in SVG: `rect` per datum, with `x`, `y`, `width`, `height`, and a fill computed from the value. |
| `plot-chart` | A scatter plot from `[x, y]` pairs, with `circle` radii derived from the data. |
| `random-plot` | The step that makes charts general: `d3.scale.linear()` domains and ranges mapping data space to pixel space, with padding for axes. The commented block at the top generates the dataset randomly instead. |
| `barchart` | Data from a file rather than a literal: `d3.csv` loads `data.csv` and the chart is drawn in the callback. |
| `csv2table` | The same CSV joined to `<tr>`/`<td>` instead of shapes — a reminder that the join is not about graphics. |
| `simple-json` | The JSON equivalent, `d3.json` loading `d3.json` and writing label/value pairs into the page. |
| `barchart2` … `barchart5` | The same bar chart four times, written in CoffeeScript with the compiled `.js` beside it: literal attributes (2), scales (3), value labels (4), and data loaded from `data.json` (5). |
| `chord-diagram` | A `d3.layout.chord()` diagram over a fixed 4×4 matrix — the one sample using a layout rather than positioning elements directly. Its data comes from the Circos guide, cited in the file. |
| `line-plus-bar-chart` | A combined line and bar chart through NVD3, a chart library built on D3, showing what the higher-level layer looks like. |
| `stacked-area-chart` | An NVD3 stacked area chart assembled from NVD3's individual model sources. |

## Running

Serve the directory over HTTP and open a sample's `index.html`:

    python3 -m http.server 8000

A file:// URL will not do for the samples that load `data.csv` or `data.json`,
since the fetch is subject to the same-origin policy.

The library itself is not committed, as the repository policy asks. Most files
expect D3 at the site root — `<script src="/d3/d3.min.js">` — so the served
tree needs `d3.min.js` at that path; `chord-diagram` instead loads D3 3.x from
`d3js.org` over plain HTTP. The two NVD3 samples additionally expect NVD3
beside them: `line-plus-bar-chart` wants `/nvd3/nv.d3.min.js`, and
`stacked-area-chart` references NVD3's own `lib/` and `src/models/` sources by
relative path, so it only runs from inside a checkout of NVD3.

The CoffeeScript sources are committed next to the JavaScript they compiled to,
so nothing needs to be compiled to run them:

    coffee -c d3js.my.coffee   # only if the .coffee file is edited

## Notes

D3 was created by Mike Bostock and first released in 2011, succeeding his
earlier Protovis. The version numbering above is the reason these files are
frozen: the 3-to-4 transition renamed most of the API surface. For anything new, read the current
[D3 documentation](https://d3js.org/) rather than these files, and treat the
directory as an illustration of the data join, which is the one part that did
not change.
