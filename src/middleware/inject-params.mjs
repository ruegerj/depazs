/**
 * Middleware which attempts to inject the received url query params in the response body by replacing the placeholders
 * with the pattern `%\<param\>%` with the value which is provided in the param. If no param is set, the given defaults
 * are taken as backup for the replacing of the placeholders in the response body.
 * @param {*} defaults key value pairs, where the key correlates to the param name and the value to the
 *  default value to be set
 */
export function injectUrlParams(defaults) {
    return (req, res, next) => {
        const queryParams = new Set([
            ...Object.keys(req.query),
            ...Object.keys(defaults),
        ]);

        // monkey patch res.send to be able to replace placeholders in the response buffer
        const send = res.send;
        res.send = function (content) {
            let body = content instanceof Buffer ? content.toString() : content;

            for (const param of queryParams) {
                const placeholder = param.toUpperCase();
                const placeholderMatcher = new RegExp(`%${placeholder}%`, 'g');

                const replaceValue = req.query[param]
                    ? req.query[param]
                    : defaults[param];

                body = body.replace(placeholderMatcher, replaceValue);
            }

            send.call(this, body);
        };

        next();
    };
}
