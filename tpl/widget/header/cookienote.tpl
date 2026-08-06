[{if $oView->isEnabled() && $smarty.cookies.displayedCookiesNotification != '1'}]
<div id="cookieNote">
    <div class="alert alert-info" style="margin:0; display:flex; align-items:flex-start; gap:0.5rem;">
        <span style="flex:1;">
            [{oxmultilang ident='COOKIE_NOTE'}]
            <span class="cancelCookie"> <a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=clearcookies"}]" title="[{oxmultilang ident='COOKIE_NOTE_DISAGREE'}]">[{oxmultilang ident='COOKIE_NOTE_DISAGREE'}]</a></span>
        </span>
        <button id="cookieNoteClose" type="button" aria-label="[{oxmultilang ident='CLOSE'}]">&times;</button>
    </div>
</div>
<script>
(function () {
    var note = document.getElementById('cookieNote');
    var btn  = document.getElementById('cookieNoteClose');
    if (!btn || !note) { return; }
    btn.addEventListener('click', function () {
        var exp = new Date();
        exp.setTime(exp.getTime() + 30 * 24 * 60 * 60 * 1000);
        document.cookie = 'displayedCookiesNotification=1;path=/;expires=' + exp.toGMTString();
        note.style.display = 'none';
    });
}());
</script>
[{/if}]
[{oxscript widget=$oView->getClassName()}]
