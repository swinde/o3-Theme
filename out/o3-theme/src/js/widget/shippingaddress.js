document.addEventListener('DOMContentLoaded', function() {

    // returns the correct reloadaddress value
    function getReloadValue(selectValue) {
        return selectValue === '-1' ? '1' : '2';
    }

    // removes edit and delete buttons inside .user__shippingaddress-change
    function removeButtons() {
        const shippingForm = document.querySelector('.user__shippingaddress-change');
        if (shippingForm) {
            shippingForm.querySelectorAll('.btn-edit, .btn-delete').forEach(button => button.remove());
        }
    }

    function setNewAddress() {

        // toggle disabled state
        const formElements = document.querySelectorAll('.user__shippingaddress-form input, .user__shippingaddress-form select');
        formElements.forEach(item => item.toggleAttribute('disabled'));

        // remove .btn-edit and .btn-delete buttons inside .user__shippingaddress-change
        removeButtons();

        // reset country and state selects
        const countrySelect = document.querySelector("select[name='deladr[oxaddress__oxcountryid]']");
        const stateSelect = document.querySelector("select[name='deladr[oxaddress__oxstateid]']");

        if (countrySelect) countrySelect.value = "";
        if (stateSelect) stateSelect.value = "";
    }

    // set form values and submit
    function submitForm() {
        const orderForm = document.querySelector("form[name='order']");
        const changeClassValue = document.querySelector("input[name='changeClass']").value;

        orderForm.querySelector("input[name='cl']").value = changeClassValue;
        orderForm.querySelector("input[name='fnc']").value = '';
        orderForm.submit();
    }

    // event listener for shipping address changes
    const addressSelect = document.querySelectorAll("input[name='oxaddressid']");
    const addressEmpty = document.querySelector("#user__shippingaddress-change");

    if(addressSelect.length !== 0) {
        addressSelect.forEach(select => {
            select.addEventListener('change', function() {
                const selectValue = this.value;
                const reloadAddressInput = document.querySelector("input[name='reloadaddress']");

                if (reloadAddressInput) {
                    reloadAddressInput.value = getReloadValue(selectValue);
                }

                if (selectValue !== '-1') {
                    // disable form validation and hide form
                    /*
                    document.querySelectorAll('.js-oxValidate').forEach(element => {
                        element.removeEventListener('submit', function() {});
                    });
                    */

                    submitForm();
                } else {
                    setNewAddress();
                }
            });
        });
    } else {
        addressEmpty.addEventListener('show.bs.collapse', function() {
            setNewAddress();
        });
        addressEmpty.addEventListener('hidden.bs.collapse', function() {
            setNewAddress();
        });
    }

});
