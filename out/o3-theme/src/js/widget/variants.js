document.addEventListener('DOMContentLoaded', function() {

    const initVariantSelects = () => {
        document.querySelectorAll('#variants .dropDown .form-select').forEach(select => {
            select.addEventListener('change', onVariantChange);
        });
    };

    const onVariantChange = (e) => {
        e.preventDefault();

        // capture and serialize form data
        const reloadForm = document.querySelector('.js-oxWidgetReload');
        let formData = serialize(reloadForm);
        const aSelects = document.querySelectorAll('select[name^=varselid]', 'form.js-oxProductForm');

        // append serialized dropdown values
        formData += Array.from(aSelects).map((select, i) => `&varselid%5B${i}%5D=${encodeURIComponent(select.value)}`).join('');

        // fetch API call
        fetch(`/widget.php?${formData}`, { method: 'GET' })
            .then(response => {
                if (!response.ok) throw new Error('Network response was not ok');
                return response.text();
            })
            .then(html => {
                // replace markup
                document.querySelector('[data-js="reload"]').outerHTML = html;

                // re-bind event listeners
                initVariantSelects();

                // re-init picture slider if thumbnails are present
                if (document.querySelector('.details__picture-thumbnails')) {
                    initPictureSlider();
                }

                // re-init product slider if present
                if (document.querySelector('.component__productslider')) {
                    initAllProductSliders();
                }

            })
            .catch(error => {
                console.error('Fetch error:', error);
            });
    };

    // initial call to set up event listeners
    initVariantSelects();

    /**
     * Serializes all form data into a query string
     * (c) 2018 Chris Ferdinandi, MIT License, https://gomakethings.com
     * @param  {Node} form - the form to serialize
     * @return {String} - the serialized form data
     */
    const serialize = (form) => {
        return Array.from(form.elements).reduce((serialized, field) => {
            if (!field.name || field.disabled || ['file', 'reset', 'submit', 'button'].includes(field.type)) {
                return serialized;
            }
            if (field.type === 'select-multiple') {
                Array.from(field.options).forEach(option => {
                    if (option.selected) {
                        serialized.push(`${encodeURIComponent(field.name)}=${encodeURIComponent(option.value)}`);
                    }
                });
            } else if ((field.type !== 'checkbox' && field.type !== 'radio') || field.checked) {
                serialized.push(`${encodeURIComponent(field.name)}=${encodeURIComponent(field.value)}`);
            }
            return serialized;
        }, []).join('&');
    };

});
