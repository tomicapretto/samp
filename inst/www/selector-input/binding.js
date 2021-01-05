const selectorInputBinding = new Shiny.InputBinding();

$.extend(selectorInputBinding, {

  find: function (scope) {
    return $(scope).find('.selector-input');
  },

  initialize: function (el) {
    const select = el.querySelector('.selection');
    const stepDown = el.querySelector('#step-down');
    const stepUp = el.querySelector('#step-up');
    const animationEnd = 'animationend webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend';

    var index = 0;
    var timeout;

    var options = $('#' + el.id  + ' option');
    var values = $.map(options, function(option) {
      return option.value;
    });

    select.textContent = values[0];

    function move(direction) {
      if (direction == "Up") {
        if (index === 0) {
          index = values.length - 1;
        } else {
          index = index - 1;
        }
      }
      if (direction == "Down") {
        if (index === values.length - 1) {
          index = 0;
        } else {
          index = index + 1;
        }
      }

      // If you click too often, the classes are not removed
      // so we do it manually.
      // I've tried with a 'selecting' bool but didn't work.
      timeout = setTimeout(function() {
        $(select).removeClass("fadeOut" + direction);
        $(select).removeClass("fadeIn" + direction);
      }, 700);

      $(select).addClass("fadeOut" + direction)
      .on(animationEnd, function() {
        $(select).removeClass("fadeOut" + direction);
        select.textContent = values[index];
        $(select).addClass("fadeIn" + direction)
        .on(animationEnd, function() {
          $(select).removeClass("fadeIn" + direction);
          clearTimeout(timeout);
        });
      });
    }

    stepDown.addEventListener('click', function () {
      move('Down');
    });

    stepUp.addEventListener('click', function () {
      move('Up');
    });
  },

  getValue: function (el) {
    const select = el.querySelector('.selection');
    return select.textContent;
  },

  subscribe: function (el, callback) {
    // Only listens when the option in the selection div changes
    const selection = el.querySelector('.selection')
    selection.addEventListener('DOMSubtreeModified', function(){
      callback();
    })
  }
});

Shiny.inputBindings.register(selectorInputBinding);
