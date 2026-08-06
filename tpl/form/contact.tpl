[{if $oxcmp_shop->oxshops__oxproductive->value}]
    [{oxscript include="js/widget/validate.min.js" priority=10}]
[{else}]
    [{oxscript include="js/widget/validate.js" priority=10}]
[{/if}]

[{assign var="editval" value=$oView->getUserData()}]
<form action="[{$oViewConf->getSslSelfLink()}]" method="post" class="needs-validation" novalidate>
    <div class="d-none">
        [{$oViewConf->getHiddenSid()}]
        <input type="hidden" name="fnc" value="send"/>
        <input type="hidden" name="cl" value="contact"/>
    </div>

    [{block name="contact_form_fields"}]
        <div class="form-floating mb-3">
            [{include
            file="form/fieldset/salutation.tpl"
            name="editval[oxuser__oxsal]"
            value=$editval.oxuser__oxsal
            class="form-select"
            required=$contactFormFields.salutation.isRequired
            }]
            <label for="editval[oxuser__oxsal]">[{oxmultilang ident="TITLE"}][{if $contactFormFields.salutation.isRequired}]*[{/if}]</label>
            <div class="invalid-feedback">
                [{oxmultilang ident="DD_FORM_VALIDATION_TITLE"}]
            </div>
        </div>

        <div class="form-floating mb-3">
            <input type="text" name="editval[oxuser__oxfname]" id="editval[oxuser__oxfname]" size=70 maxlength=255 value="[{$editval.oxuser__oxfname}]" class="form-control" placeholder="[{oxmultilang ident="FIRST_NAME"}]"[{if $contactFormFields.firstName.isRequired}] required[{/if}] autocomplete="given-name">
            <label for="editval[oxuser__oxfname]">[{oxmultilang ident="FIRST_NAME"}][{if $contactFormFields.firstName.isRequired}]*[{/if}]</label>
            <div class="invalid-feedback">
                [{oxmultilang ident="DD_FORM_VALIDATION_FIRST_NAME"}]
            </div>
            [{include file="message/inputvalidation.tpl" aErrors=$aErrors.oxuser__oxfname}]
        </div>

        <div class="form-floating mb-3">
            <input type="text" class="form-control" id="editval[oxuser__oxlname]" name="editval[oxuser__oxlname]" value="[{$editval.oxuser__oxlname}]" placeholder="[{oxmultilang ident="LAST_NAME"}][{if $contactFormFields.lastName.isRequired}]*[{/if}]"[{if $contactFormFields.lastName.isRequired}] required[{/if}] autocomplete="family-name">
            <label for="editval[oxuser__oxlname]">[{oxmultilang ident="LAST_NAME"}][{if $contactFormFields.lastName.isRequired}]*[{/if}]</label>
            <div class="invalid-feedback">
                [{oxmultilang ident="DD_FORM_VALIDATION_LAST_NAME"}]
            </div>
            [{include file="message/inputvalidation.tpl" aErrors=$aErrors.oxuser__oxlname}]
        </div>

        <div class="form-floating mb-3">
            <input id="contactEmail" type="email" name="editval[oxuser__oxusername]" size=70 maxlength=255 value="[{$editval.oxuser__oxusername}]" class="form-control" placeholder="[{oxmultilang ident="EMAIL"}][{if $contactFormFields.email.isRequired}]*[{/if}]" autocomplete="email"[{if $contactFormFields.email.isRequired}] required[{/if}]>
            <label for="contactEmail">[{oxmultilang ident="EMAIL"}][{if $contactFormFields.email.isRequired}]*[{/if}]</label>
            <div class="invalid-feedback">
                [{oxmultilang ident="DD_FORM_VALIDATION_VALIDEMAIL"}]
            </div>
        </div>

        <div class="form-floating mb-3">
            <input type="text" name="c_subject" id="c_subject" size="70" maxlength=80 value="[{$oView->getContactSubject()}]" class="form-control" placeholder="[{oxmultilang ident="SUBJECT"}][{if $contactFormFields.subject.isRequired}]*[{/if}]"[{if $contactFormFields.subject.isRequired}] required[{/if}]>
            <label for="c_subject">[{oxmultilang ident="SUBJECT"}][{if $contactFormFields.subject.isRequired}]*[{/if}]</label>
            <div class="invalid-feedback">
                [{oxmultilang ident="O3_FORM_VALIDATION_SUBJECT"}]
            </div>
        </div>

        <div class="form-floating mb-3">
            <textarea name="c_message" id="c_message" class="form-control" placeholder="[{oxmultilang ident="MESSAGE"}][{if $contactFormFields.message.isRequired}]*[{/if}]"[{if $contactFormFields.message.isRequired}] required[{/if}]>[{$oView->getContactMessage()}]</textarea>
            <label for="c_message">[{oxmultilang ident="MESSAGE"}][{if $contactFormFields.message.isRequired}]*[{/if}]</label>
            <div class="invalid-feedback">
                [{oxmultilang ident="O3_FORM_VALIDATION_MESSAGE"}]
            </div>
        </div>
    [{/block}]

    [{block name="captcha_form"}][{if method_exists($oViewConf, 'getCaptchaWidget')}][{$oViewConf->getCaptchaWidget('contact')}][{/if}][{/block}]

    [{block name="contact_form_buttons"}]
        <p class="alert alert-info">[{oxmultilang ident="COMPLETE_MARKED_FIELDS"}]</p>
        <button class="btn btn-primary" type="submit">
            [{oxmultilang ident="SEND"}]
        </button>
    [{/block}]
</form>
