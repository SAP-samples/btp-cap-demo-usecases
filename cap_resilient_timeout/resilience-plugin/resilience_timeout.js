/* eslint-disable no-unused-vars */
/* eslint-disable no-undef */
// Default Options: Values and Functions
const DEFAULT_DISABLE_LIST  = [ "setHeaders", "write", "send", "json", "status", "type",
                                "end", "writeHead", "addTrailers", "writeContinue", "append",
                                "attachment", "download", "format", "jsonp", "location",
                                "redirect", "render", "sendFile", "sendStatus"  ];
const DEFAULT_TIMEOUT       = 10 * 1000; 
const DEFAULT_ON_TIMEOUT    = function (req, res){
    res.status(503).send({error: 'Service is taking longer than expected. Please retry!'});
}

//Implementation: Functions and Handlers
initialiseOptions = (options)=>{
    options = options || {};

    if (options.timeout && (typeof options.timeout !== 'number' || options.timeout % 1 !== 0 || options.timeout <= 0)) {
		throw new Error('Timeout option must be a whole number greater than 0!');
	}

    if (options.onTimeout && typeof options.onTimeout !== 'function') {
		throw new Error('onTimeout option must be a function!');
	}

    if (options.disable && !Array.isArray(options.disable)) {
		throw new Error('disable option must be an array!');
	}

    options.timeout     = options.timeout     || DEFAULT_TIMEOUT;
    options.onTimeout   = options.onTimeout   || DEFAULT_ON_TIMEOUT;
    options.disableList = options.disableList || DEFAULT_DISABLE_LIST;
    return options;
}

timeoutMiddleware = function (req, res, next){
    req.connection.setTimeout(this.config.timeout);
    res.on('timeout', (socket)=>{
        if (!res.headersSent) {
            this.config.onTimeout(req, res, next);
            this.config.disableList.forEach( method => {
                res[method] = function(){console.error(`ERROR: ${method} was called after TimeOut`)};
            });
        }
    });
    next();
}

timeoutHandler = (options)=>{
    this.config = initialiseOptions(options);
    return timeoutMiddleware.bind(this);
}

module.exports = {timeoutHandler};