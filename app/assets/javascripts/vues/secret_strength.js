//= require zxcvbn/dist/zxcvbn

$(document).on('turbolinks:load', function () {
  var rootElementSelector = '#secret-strength';
  if ($(rootElementSelector).length === 0) {
    return;
  }
  function labelClass(name) {
    return 'label label-' + name;
  }
  var labelStyles = ['danger', 'warning', 'primary', 'info', 'success'];
  var labelTexts = [I18n.passwordStrength.tooGuessable, I18n.passwordStrength.veryGuessable, I18n.passwordStrength.somewhatGuessable, I18n.passwordStrength.safelyUnguessable, I18n.passwordStrength.veryUnguessable];

  var app = new Vue({
    el: rootElementSelector,
    updated: function () {
      // TODO (PS) workaround for binding-issues with bootstrap-tooltip
      $(this.$el).find('#password-strength-label').tooltip('destroy').tooltip();
    },
    data: {
      level: I18n.passwordStrength.unknown,
      secret: '',
      tooltip: '',
      label: labelClass('default')
    },
    methods: {
      checkLevel: function () {
        var result = zxcvbn(this.secret);
        if (result.score <= 2) {
          this.tooltip = result.feedback.warning + ' ' + result.feedback.suggestions.join(', ');
        } else {
          this.tooltip = '✅';
        }
        if (this.secret.length < 1) {
          this.label = labelClass('default');
          this.level = I18n.passwordStrength.unknown;
        } else {
          this.label = labelClass(labelStyles[result.score]);
          this.level = labelTexts[result.score];
        }
      }
    }
  });
});
