// Update the state of the buttons based on current value
function updateButtons(inputField, minusButton, plusButton, warningBox) {
    const currentValue = parseFloat(inputField.value);
    const min = parseFloat(inputField.getAttribute('min')) || 1;
    const max = parseFloat(inputField.getAttribute('max')) || Infinity;

    // Minus button disable logic
    if (currentValue <= min) {
        minusButton.setAttribute('disabled', 'disabled');
    } else {
        minusButton.removeAttribute('disabled');
    }

    // Plus button disable logic
    if (currentValue >= max) {
        plusButton.setAttribute('disabled', 'disabled');
        if (warningBox) warningBox.classList.remove('d-none');
    } else {
        plusButton.removeAttribute('disabled');
        if (warningBox) warningBox.classList.add('d-none');
    }
}

// Modify the input value by attribute "step"
function modifyValue(inputField, change) {
    let currentValue = parseFloat(inputField.value);
    const min = parseFloat(inputField.getAttribute('min')) || 1;
    const max = parseFloat(inputField.getAttribute('max')) || Infinity;

    let newValue;

    // If the current value is a decimal number
    if (currentValue % 1 !== 0) {
        if (change > 0) {
            // Plus: Round up to the nearest integer
            newValue = Math.ceil(currentValue);
        } else {
            // Minus: Round down to the nearest integer
            newValue = Math.floor(currentValue);
        }
    } else {
        // If already an integer: Increase/decrease by 1 as normal
        newValue = currentValue + change;
    }

    // Apply min and max boundaries
    newValue = Math.max(newValue, min);
    newValue = Math.min(newValue, max);

    // Set the new value (immer Ganzzahl nach Button-Klick)
    inputField.value = Math.round(newValue);
}

// Schedule form submission with delay if form[data-js="tobasket-change"]
let submitTimeout;
function scheduleSubmit(form) {
    if (form) {
        // Clear any existing timeout to avoid rapid submits
        clearTimeout(submitTimeout);

        // Set a new timeout to submit the form after a delay (e.g., 500ms)
        submitTimeout = setTimeout(function () {
            form.submit();
        }, 500); // Adjust the delay (500ms) as needed
    }
}

function initTobasket() {
    document.querySelectorAll('[data-js="tobasket"]:not([data-tobasket-bound])').forEach(function (basket) {
        basket.setAttribute('data-tobasket-bound', 'true');

        const minusButton = basket.querySelector('[data-js="tobasket-minus"]');
        const plusButton = basket.querySelector('[data-js="tobasket-plus"]');
        const inputField = basket.querySelector('[data-js="tobasket-input"]');
        const form = basket.closest('form[data-js="tobasket-change"]');
        const warningBox = basket.querySelector('[data-js="stock-warning"]');

        // Event listener for minus button
        minusButton.addEventListener('click', function () {
            modifyValue(inputField, -1);
            updateButtons(inputField, minusButton, plusButton, warningBox);
            scheduleSubmit(form);
        });

        // Event listener for plus button
        plusButton.addEventListener('click', function () {
            modifyValue(inputField, 1);
            updateButtons(inputField, minusButton, plusButton, warningBox);
            scheduleSubmit(form);
        });

        // Event listener for manual input change
        inputField.addEventListener('input', function () {
            const rawValue = inputField.value;

            // Do nothing if the field is empty or consists only of a period/comma
            if (rawValue === '' || rawValue === '.' || rawValue === ',') {
                return;
            }

            // Replace comma with period for parseFloat
            const normalizedValue = rawValue.replace(',', '.');
            let value = parseFloat(normalizedValue);

            const min = parseFloat(inputField.getAttribute('min')) || 1;
            const max = parseFloat(inputField.getAttribute('max')) || Infinity;
            const allowDecimal = inputField.getAttribute('data-allow-decimal') === 'true';

            // If the user is still typing (ends with . or contains an incomplete decimal number)
            // Update buttons only, do NOT change value
            if (normalizedValue.endsWith('.') || normalizedValue.endsWith(',')) {
                if (!isNaN(value)) {
                    updateButtons(inputField, minusButton, plusButton, warningBox);
                }
                return;
            }

            if (isNaN(value)) {
                value = min;
                inputField.value = value;
                updateButtons(inputField, minusButton, plusButton, warningBox);
                scheduleSubmit(form);
                return;
            }

            // Check min/max
            let needsUpdate = false;

            if (value < min) {
                value = min;
                needsUpdate = true;
            }

            if (value > max) {
                value = max;
                needsUpdate = true;
            }

            // Rounding only if decimal numbers are NOT allowed
            if (!allowDecimal && value !== Math.round(value)) {
                value = Math.round(value);
                needsUpdate = true;
            }

            // Only set the value if it has changed
            if (needsUpdate) {
                inputField.value = value;
            }

            updateButtons(inputField, minusButton, plusButton, warningBox);
            scheduleSubmit(form);
        });
    });
}

window.initTobasket = initTobasket;
initTobasket();
