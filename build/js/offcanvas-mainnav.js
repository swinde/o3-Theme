let nav = document.querySelector("#offcanvas__mainnav .nav");
let navExpand = [].slice.call(document.querySelectorAll('.nav-expand'));
let navBox = document.querySelector('#offcanvas__mainnav .offcanvas-body');

navExpand.forEach(function (item) {
    item.querySelector('.nav-expand-link').addEventListener('click', function (e) {
        e.preventDefault();
        e.stopPropagation();
        nav.classList.add(this.dataset.level);
        navBox.scrollTop = 0;
        return item.classList.add('active');
    });
    item.querySelector('.nav-back-link').addEventListener('click', function () {
        nav.classList.remove(this.dataset.levelBack);
        navBox.scrollTop = 0;
        return item.classList.remove('active');
    });
});

