//= require zxcvbn/dist/zxcvbn

$(document).on('turbolinks:load', function () {
  var rootElementSelector = '#secret-strength';
  if ($(rootElementSelector).length === 0) {
    return;
  }

  var app = new Vue({
    el: rootElementSelector,
    updated: function () {
      // TODO (PS) workaround for binding-issues with bootstrap-tooltip
      $(this.$el).find('#password-strength-label').tooltip('destroy').tooltip();
    },
    data: {
      secret: '',
      labelStyles: ['danger', 'warning', 'primary', 'info', 'success'],
      labelTexts: [I18n.passwordStrength.tooGuessable, I18n.passwordStrength.veryGuessable, I18n.passwordStrength.somewhatGuessable, I18n.passwordStrength.safelyUnguessable, I18n.passwordStrength.veryUnguessable],
    },
    computed: {
      result: function () {
        return zxcvbn(this.secret);
      },
      tooltip: function () {
        if (this.result.score <= 2) {
          return this.result.feedback.warning + ' ' + this.result.feedback.suggestions.join(', ');
        } else {
          return '✅';
        }
      },
      label: function () {
        if (this.secret.length < 1) {
          return this.labelClass('default');
        } else {
          return this.labelClass(this.labelStyles[this.result.score]);
        }
      },
      level: function () {
        if (this.secret.length < 1) {
          return I18n.passwordStrength.unknown;
        } else {
          return this.labelTexts[this.result.score];
        }
      }
    },
    methods: {
      labelClass: function (name) {
        return 'label label-' + name;
      }
    }
  });
});
