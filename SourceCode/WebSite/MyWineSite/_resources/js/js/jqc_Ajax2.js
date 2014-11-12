/*global
jQuery, $, alert, RWPJS, location, document, window, self, top
*/
var RWPJS = RWPJS || {};

RWPJS.Ajax2 = {};

jQuery.support.cors = true;

RWPJS.Ajax2.hostStr = function () {
    "use strict";
    var hostStr = '';
    if (window.location.hostname.indexOf('localhost') > -1) {
        hostStr = 'http://myrheem.localhost.com:8106/v1/';
    } else if (window.location.hostname.indexOf('s3.amazonaws.com') > -1) {
        hostStr = 'http://atlwebdev100:8106/v1/';
    } else if (window.location.hostname.indexOf('atlwebdev100') > -1) {
        hostStr = 'http://atlwebdev100:8106/v1/';
    } else if (window.location.hostname.indexOf('rheembeta') > -1) {
        hostStr = 'http://myrheem.rheembeta.com:8106/v1/';
    } else {
        if (location.href.indexOf("https://") === -1) {
            hostStr = 'http://io.myrheem.com:8106/v1/';
        } else {
            hostStr = 'https://io.myrheem.com/v1/';
        }
    }

    return hostStr;
};

RWPJS.Ajax2.disconnectFromGoogle = function (accessToken, handlerCallBackFunc) {
    "use strict";
    $.ajax({
        type: 'GET',
        url: 'https://accounts.google.com/o/oauth2/revoke?token=' + accessToken,
        async: true,
        crossDomain: true,
        contentType: 'application/json',
        dataType: 'jsonp',
        success: function (msg) {
            handlerCallBackFunc(msg);
        },
        error: function (e) {
            alert("ERROR: " + e);
        }
    });
};

RWPJS.Ajax2.handleErrors = function (xhr, status, error, url) {
    "use strict";
    var errObj, i, errorHandled, errMsg;
    errorHandled = false;
    errMsg = '';
    switch (xhr.status) {
        case 401:
            errObj = jQuery.parseJSON(xhr.responseText);
            for (i in errObj.ErrorList) {
                if (errObj.ErrorList[i] === 'Bearer Token Expired' || errObj.ErrorList[i] === 'Invalid Bearer Token') {
                    errorHandled = true;
                    alert("Session expired. Please login again.");
                    break;
                } else {
                    alert("401 ErrorList:" + errObj.ErrorList[i]);
                    errorHandled = true;
                }
            }
            break;
        case 404:
            errMsg = "Server error (" + xhr.status + ") " + xhr.statusText + '\n';
            alert(errMsg);
            errorHandled = true;
            break;
        case 0:
            if (status === 'error' && error == '') {
                alert('No response from server at: ' + url);
                errorHandled = true;
            }
            break;
    }

    if (!errorHandled) {
        errObj = jQuery.parseJSON(xhr.responseText);
        if (errObj.ErrorList) {
            var eMsg = '';
            for (i in errObj.ErrorList) {
                eMsg += errObj.ErrorList[i];
            }
            alert(eMsg);
        } else {
            errMsg = "Server error (" + xhr.status + ") \n";
            alert(errMsg);
        }

    }
};

RWPJS.Ajax2.publicGetData = function (webMethod, handlerCallBackFunc) {
    "use strict";

    var headerObj = { Accept: "application/json; charset=utf-8" };

    $.ajax({
        type: "GET",
        async: true,
        url: webMethod,
        cache: false,
        headers: headerObj,
        crossDomain: true,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {
            handlerCallBackFunc(msg);
        },
        error: function (xhr, status, error) {
            RWPJS.Ajax2.handleErrors(xhr, status, error, webMethod);
        }
    });
};

RWPJS.Ajax2.getData = function (bearerToken, clientID, webMethod, handlerCallBackFunc) {
    "use strict";
    var authStr;
    authStr = 'Bearer: ' + bearerToken;
    $.ajax({
        type: "GET",
        async: true,
        url: webMethod,
        cache: false,
        crossDomain: true,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        headers: { 'Authorization': authStr, 'X-ClientID': clientID },
        success: function (msg) {
            handlerCallBackFunc(msg);
        },
        error: function (xhr, status, error) {
            RWPJS.Ajax2.handleErrors(xhr, status, error, this.url);
        }
    });

};

RWPJS.Ajax2.postData = function (bearerToken, clientID, webMethod, dataObj, handlerCallBackFunc) {
    var authStr, timestamp, tsString;
    timestamp = new Date();
    tsString = timestamp.getTime();
    authStr = 'Bearer: ' + bearerToken;
    $.ajax({
        url: webMethod,
        crossDomain: true,
        data: JSON.stringify(dataObj),
        dataType: 'json',
        type: 'POST',
        async: true,
        contentType: 'application/json; charset=utf-8',
        headers: { 'Authorization': authStr, 'X-ClientID': clientID, 'X-Timestamp': tsString },
        success: function (jsondata, textStatus, jqXHR) {
            // TODO add some stuff to handle a bad return by checking textStatus and jqXHR
            handlerCallBackFunc(jsondata);
        },
        error: function (xhr, status, error) {
            RWPJS.Ajax2.handleErrors(xhr, status, error, this.url);
        }
    })
};

RWPJS.Ajax2.putData = function (bearerToken, clientID, webMethod, dataObj, handlerCallBackFunc) {
    var authStr, timestamp, tsString;
    timestamp = new Date();
    tsString = timestamp.getTime();
    authStr = 'Bearer: ' + bearerToken;
    $.ajax({
        url: webMethod,
        crossDomain: true,
        data: JSON.stringify(dataObj),
        dataType: 'json',
        type: 'PUT',
        async: true,
        contentType: 'application/json; charset=utf-8',
        headers: { 'Authorization': authStr, 'X-ClientID': clientID, 'X-Timestamp': tsString },
        success: function (jsondata, textStatus, jqXHR) {
            // TODO add some stuff to handle a bad return by checking textStatus and jqXHR
            handlerCallBackFunc(jsondata);
        },
        error: function (xhr, status, error) {
            RWPJS.Ajax2.handleErrors(xhr, status, error, this.url);
        }
    })
};

RWPJS.Ajax2.deleteObject = function (bearerToken, clientID, webMethod, handlerCallBackFunc) {
    var authStr;
    authStr = 'Bearer: ' + bearerToken;
    $.ajax({
        url: webMethod,
        crossDomain: true,
        dataType: 'json',
        type: 'DELETE',
        async: true,
        contentType: 'application/json; charset=utf-8',
        headers: { 'Authorization': authStr, 'X-ClientID': clientID },
        success: function (jsondata, textStatus, jqXHR) {
            // TODO add some stuff to handle a bad return by checking textStatus and jqXHR
            handlerCallBackFunc(jsondata);
        },
        error: function (xhr, status, error) {
            RWPJS.Ajax2.handleErrors(xhr, status, error, this.url);
        }
    })
};

RWPJS.Ajax2.getByProxy = function (webMethod, handlerCallBackFunc, handleErrorCallBackFunc) {
    "use strict";
    $.ajax({
        type: "POST",
        url: "/AdminTools/APIInterface.aspx",
        async: true,
        data: { HttpMethod: 'GET', Route: webMethod, Data: '' },

        beforeSend: function () {
            // show image here
            if ($('#ajaxBusy') != null) {
                $("#ajaxBusy").show();
            }
        },
        complete: function () {
            // hide image here
            if ($('#ajaxBusy') != null) {
                $("#ajaxBusy").hide();
            }
        },

        success: function (msg) {
            handlerCallBackFunc(msg);
        },
        error: function (xhr, status, error) {
            if (handleErrorCallBackFunc) {
                handleErrorCallBackFunc(xhr, status, error, this.url);
            } else {
                RWPJS.Ajax2.handleErrors(xhr, status, error, this.url);
            }
        }
    });
};

RWPJS.Ajax2.postByProxy = function (webMethod, dataObj, handlerCallBackFunc) {
    "use strict";
    $.ajax({
        type: "POST",
        url: "/AdminTools/APIInterface.aspx",
        async: true,
        data: { HttpMethod: 'POST', Route: webMethod, Data: JSON.stringify(dataObj) },

        beforeSend: function () {
            // show image here
            if ($('#ajaxBusy') != null) {
                $("#ajaxBusy").show();
            }
        },
        complete: function () {
            // hide image here
            if ($('#ajaxBusy') != null) {
                $("#ajaxBusy").hide();
            }
        },


        success: function (msg) {
            handlerCallBackFunc(msg);
        },
        error: function (xhr, status, error) {
            RWPJS.Ajax2.handleErrors(xhr, status, error, this.url);
        }
    });
};

RWPJS.Ajax2.putByProxy = function (webMethod, dataObj, handlerCallBackFunc) {
    "use strict";
    $.ajax({
        type: "POST",
        url: "/AdminTools/APIInterface.aspx",
        async: true,
        data: { HttpMethod: 'PUT', Route: webMethod, Data: JSON.stringify(dataObj) },
        success: function (msg) {
            handlerCallBackFunc(msg);
        },
        error: function (xhr, status, error) {
            RWPJS.Ajax2.handleErrors(xhr, status, error, this.url);
        }
    });
};

RWPJS.Ajax2.deleteByProxy = function (webMethod, handlerCallBackFunc, handleErrorCallBackFunc) {
    "use strict";
    $.ajax({
        type: "POST",
        url: "/AdminTools/APIInterface.aspx",
        async: true,
        data: { HttpMethod: 'DELETE', Route: webMethod, Data: '' },
        success: function (msg) {
            handlerCallBackFunc(msg);
        },
        error: function (xhr, status, error) {
            if (handleErrorCallBackFunc) {
                handleErrorCallBackFunc(xhr, status, error, this.url);
            } else {
                RWPJS.Ajax2.handleErrors(xhr, status, error, this.url);
            }
        }
    });
};

RWPJS.Ajax2.getParameterByName = function (name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}


RWPJS.Ajax2.currentPersonId = function () {
    "use strict";
    return RWPJS.Ajax2.readCookie('MyRheemUser');
};

RWPJS.Ajax2.readCookie = function (name) {
    var nameEQ, ca, i, c, result;
    nameEQ = name + "=";
    ca = document.cookie.split(';');
    result = null;
    for (i = 0; i < ca.length; i++) {
        c = ca[i];
        while (c.charAt(0) == ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) == 0) {
            result = c.substring(nameEQ.length, c.length);
            break;
        }
    }
    return result;
};

