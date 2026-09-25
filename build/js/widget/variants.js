document.addEventListener('DOMContentLoaded', function() {

    const initVariantSelects = () => {
        document.querySelectorAll('#variants .dropDown .form-select').forEach(select => {
            select.addEventListener('change', onVariantChange);
        });
    };

    const onVariantChange = (e) => {
        e.preventDefault();

        // Formulardaten erfassen und serialisieren
        const reloadForm = document.querySelector('.js-oxWidgetReload');
        let formData = serialize(reloadForm);
        const aSelects = document.querySelectorAll('select[name^=varselid]', 'form.js-oxProductForm');

        // Serialisierte Dropdown-Werte anhängen
        formData += Array.from(aSelects).map((select, i) => `&varselid%5B${i}%5D=${encodeURIComponent(select.value)}`).join('');

        // AJAX-Aufruf mit fetch API
        fetch(`/widget.php?${formData}`, { method: 'GET' })
            .then(response => {
                if (!response.ok) throw new Error('Netzwerk-Antwort war nicht ok');
                return response.text();
            })
            .then(html => {
                // Markup ersetzen
                document.querySelector('[data-js="reload"]').outerHTML = html;

                // Event-Listener erneut binden
                initVariantSelects();

                // Tobasket-Listener erneut binden (fuer +/- Buttons)
                if (typeof window.initTobasket === 'function') {
                    window.initTobasket();
                }

                // Bilderslider neu initialisieren, wenn Thumbnails vorhanden sind
                if (document.querySelector('.details__picture-thumbnails')) {
                    initPictureSlider();
                }

                // Cross-Selling-Slider neu initialisieren, falls vorhanden
                if (document.querySelector('.component__productslider')) {
                    initAllProductSliders();
                }

            })
            .catch(error => {
                console.error('Fetch-Fehler:', error);
            });
    };

    // Initialer Aufruf zur Einrichtung der Event-Listener
    initVariantSelects();

    /**
     * Serialisiert alle Formulardaten in einen Query-String
     * (c) 2018 Chris Ferdinandi, MIT License, https://gomakethings.com
     * @param  {Node} form - Das zu serialisierende Formular
     * @return {String} - Die serialisierten Formulardaten
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