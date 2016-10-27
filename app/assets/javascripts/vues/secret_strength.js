//= require zxcvbn

$(document).on('turbolinks:load', function () {
  function labelClass(name) {
    return 'label label-' + name;
  }
  var labelStyles = ['danger', 'warning', 'primary', 'info', 'success'];
  var labelTexts = [I18n.passwordStrength.tooGuessable, I18n.passwordStrength.veryGuessable, I18n.passwordStrength.somewhatGuessable, I18n.passwordStrength.safelyUnguessable, I18n.passwordStrength.veryUnguessable];

  var app = new Vue({
    el: '#secret-strength',
    updated: function () {
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
