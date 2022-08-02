func (u *User) Receive(notification Notification) {
	u.logReceivedNotification(notification)
	if notification.ID == u.lastNotificationID {
		u.l.Debug("notificationID same as lastNotificationID", zap.String("notificationID", notification.ID))
		return
	}
	u.repo.SaveNotification(notification)
	u.broadcaster.Broadcast(notification)
	u.lastNotificationID = notification.ID
	u.logNotificationSaved(notification)
}
