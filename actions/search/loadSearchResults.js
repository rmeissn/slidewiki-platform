import {shortTitle} from '../../configs/general';

export default function loadSearchResults(context, payload, done) {
    if (payload.params.searchstring === undefined)
        console.log("Nothing to search.");

    context.service.read('searchresults.list', payload, {timeout: 20 * 1000}, (err, res) => {
        if (err) {
            context.dispatch('LOAD_RESULTS_FAILURE', err);
        } else {
            context.dispatch('LOAD_RESULTS_SUCCESS', res);
        }

        done();
    });
}
