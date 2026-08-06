document.addEventListener("DOMContentLoaded", () => {
    // find all buttons with the data-js-noticelist attribute
    const buttons = document.querySelectorAll('button[data-js-noticelist]');

    buttons.forEach(button => {
        button.addEventListener('click', event => {
            event.preventDefault(); // prevent default button submit behaviour

            // get the form by the value in the data-js-noticelist attribute
            const formId = button.dataset.jsNoticelist;
            const targetForm = document.getElementById(formId);

            // submit the form if found, otherwise log an error
            targetForm?.submit() || console.error(`Form with id "${formId}" not found.`);
        });
    });
});
