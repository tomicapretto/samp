const numberInputBinding = new Shiny.InputBinding();

$.extend(numberInputBinding, {
  
  find: function (scope) {
    return $(scope).find('.number-input');
  },
  
  initialize: function (el) {
    const input = el.querySelector('input');
    const stepDown = el.querySelector('#step-down');
    const stepUp = el.querySelector('#step-up');
    const step = Number(input.step);
    const min = input.min ? Number(input.min) : -Infinity;
    const max = input.max ? Number(input.max) : Infinity;
    
    const getValue = function setValue(step) {
      const inputValue = Number(input.value);
      const value = inputValue + step;
      if (value < min || value > max) {
        return inputValue;
      }
      return value;
    };
    
    var t1, t2, i1, i2;
    
    function clearTimeouts() {
      clearTimeout(t1);
      clearTimeout(t2);
      clearInterval(i1);
      clearInterval(i2);
    }
    
    stepDown.addEventListener('mousedown', function () {
      input.value = getValue(step * -1);
      t1 = setTimeout(function() {
          i1 = setInterval(function() {
              input.value = getValue(step * -1);
          }, 50);
      }, 500);

      t2 = setTimeout(function() {
          i2 = setInterval(function() {
              input.value = getValue(step * -1);
          }, 5);
      }, 2000);
    });
    
    stepDown.addEventListener('mouseup', function () {
      clearTimeouts();
    });
    
    stepDown.addEventListener('mouseleave', function () {
      clearTimeouts();
    });
    
    stepUp.addEventListener('mousedown', function () {
      input.value = getValue(step);
      t1 = setTimeout(function() {
          i1 = setInterval(function() {
              input.value = getValue(step);
          }, 50);
      }, 500);

      t2 = setTimeout(function() {
          i2 = setInterval(function() {
              input.value = getValue(step);
          }, 5);
      }, 2000);
    });
    
    stepUp.addEventListener('mouseup', function () {
      clearTimeouts();
    });
    
    stepUp.addEventListener('mouseleave', function () {
      clearTimeouts();
    });
  },
  getValue: function (el) {
    const input = el.querySelector('input');
    return parseFloat(input.value);
  },
  subscribe: function (el, callback) {
    const controls = el.querySelector('.number-input-controls');
    controls.addEventListener('click', function () {
      callback();
    });
    controls.addEventListener('change', function () {
      callback();
    });
    controls.addEventListener('input', function () {
      callback();
    });
  },
  receiveMessage: function (el, message) {
    const input = el.querySelector('input');
    const controls = el.querySelector('.number-input-controls');
    input.value = message.value;
    $(controls).trigger('click');
  },
});

Shiny.inputBindings.register(numberInputBinding);