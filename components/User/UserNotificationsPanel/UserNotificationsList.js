import React from 'react';
import UserNotificationsItem from './UserNotificationsItem';

class UserNotificationsList extends React.Component {
    render() {
        const selector = this.props.selector;

        const list = this.props.items.map((notification, index) => {
            if (notification.visible) {
                return (
                    <UserNotificationsItem notification={notification} key={index} selector={selector} />
                );
            }
        });

        return (
            <div ref="usernotificationsList">
                <div className="ui relaxed divided list">
                    {list}
                </div>
             </div>
        );
    }
}

export default UserNotificationsList;
