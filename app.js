import Fluxible from 'fluxible';
import fetchrPlugin from 'fluxible-plugin-fetchr';
import Application from './components/Application';
import ApplicationStore from './stores/ApplicationStore';
import RouteStore from './stores/RouteStore';
import ContributorsStore from './stores/ContributorsStore';
import ContentStore from './stores/ContentStore';
import DeckViewStore from './stores/DeckViewStore';
import DeckEditStore from './stores/DeckEditStore';
import SlideViewStore from './stores/SlideViewStore';
import SlideEditStore from './stores/SlideEditStore';
import DataSourceStore from './stores/DataSourceStore';
import ActivityFeedStore from './stores/ActivityFeedStore';
import DeckTreeStore from './stores/DeckTreeStore';
import TranslationStore from './stores/TranslationStore';

// create new fluxible instance & register all stores
const app = new Fluxible({
    component: Application,
    stores: [
        RouteStore,
        ApplicationStore,
        ContributorsStore,
        ContentStore,
        DeckViewStore,
        DeckEditStore,
        SlideViewStore,
        SlideEditStore,
        DataSourceStore,
        ActivityFeedStore,
        DeckTreeStore,
        TranslationStore
    ]
});

// register plugins
app.plug(fetchrPlugin({
    xhrPath: '/api' // Path for XHR to be served from
}));

module.exports = app;
