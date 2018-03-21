$(document).on('ready page:load page:change turbolinks:load', function() {
  const cleanSource = function(html) {
    let lines = html.split(/\n/);
    lines.shift();
    lines.splice(-1, 1);
    const indentSize = lines[0].length - lines[0].trim().length;
    const re = new RegExp(` {${indentSize}}`);
    lines = lines.map(function(line) {
      if (line.match(re)) { line = line.substring(indentSize); }
      return line;
    });
    lines = lines.join("\n");
    return lines;
  };
  const $button = $("<div id='source-button' class='btn btn-primary btn-xs'>&lt; &gt;</div>").click(function() {
    let html = $(this).parent().html();
    html = cleanSource(html);
    $("#source-modal pre").text(html);
    $("#source-modal").modal();
  });
  $(".bs-component").hover((function() {
    $(this).append($button);
    $button.show();
  }), function() {
    $button.hide();
  });
});
