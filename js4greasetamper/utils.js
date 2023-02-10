function display(method, url) {
    console.log('XHR finished loading', method, url);
}

function isAllXhrComplete() {
    window.activeAjaxCount--;
    if (window.activeAjaxCount === 0) {
        //execute something here.
    }

}

(function (open) {
    XMLHttpRequest.prototype.open = function (method, url, async, user, pass) {
        this.addEventListener("load", isAllXhrComplete);
        open.call(this, method, url, async, user, pass);
        display(method, url);
    };
})(XMLHttpRequest.prototype.open);


(function (send) {
    XMLHttpRequest.prototype.send = function () {
        window.activeAjaxCount++;
        return send.call(this, arguments);
    };
})(XMLHttpRequest.prototype.send);