document.copyToClipboard = (hint, text) ->
  window.prompt(hint, text)

$(document).on 'ready page:load page:change turbolinks:load', ->
  $('[data-toggle="popover"]').popover()
  $('[data-toggle="tooltip"]').tooltip()

  cleanSource = (html) ->
    lines = html.split(/\n/)
    lines.shift()
    lines.splice -1, 1
    indentSize = lines[0].length - lines[0].trim().length
    re = new RegExp(" {" + indentSize + "}")
    lines = lines.map((line) ->
      line = line.substring(indentSize)  if line.match(re)
      line
    )
    lines = lines.join("\n")
    lines
  $button = $("<div id='source-button' class='btn btn-primary btn-xs'>&lt; &gt;</div>").click(->
    html = $(this).parent().html()
    html = cleanSource(html)
    $("#source-modal pre").text html
    $("#source-modal").modal()
    return
  )
  $(".bs-component").hover (->
    $(this).append $button
    $button.show()
    return
  ), ->
    $button.hide()
    return

  $('input.notice-password').on 'keyup change', ->
    if $('input.notice-password').val().length < 2
      return
    $('.password-strength-indicator .label').removeClass('label-danger')
    $('.password-strength-indicator .label').removeClass('label-warning')
    $('.password-strength-indicator .label').removeClass('label-primary')
    $('.password-strength-indicator .label').removeClass('label-info')
    $('.password-strength-indicator .label').removeClass('label-success')
    result = zxcvbn($('input.notice-password').val())
    switch result.score
      when 0
        $('.password-strength-indicator .label').addClass('label-danger')
        $('.password-strength-indicator .label').text(I18n.passwordStrength.tooGuessable)
      when 1
        $('.password-strength-indicator .label').addClass('label-warning')
        $('.password-strength-indicator .label').text(I18n.passwordStrength.veryGuessable)
      when 2
        $('.password-strength-indicator .label').addClass('label-primary')
        $('.password-strength-indicator .label').text(I18n.passwordStrength.somewhatGuessable)
      when 3
        $('.password-strength-indicator .label').addClass('label-info')
        $('.password-strength-indicator .label').text(I18n.passwordStrength.safelyUnguessable)
      when 4
        $('.password-strength-indicator .label').addClass('label-success')
        $('.password-strength-indicator .label').text(I18n.passwordStrength.veryUnguessable)
    if result.feedback
      $('.password-strength-indicator .label').attr('data-original-title', result.feedback.warning + ' ' + result.feedback.suggestions.join(', '))
