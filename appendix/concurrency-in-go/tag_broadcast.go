func (t *Tag) broadcast(notification Notification) error {
	if len(t.Users) == 0 {
		// log
		return fmt.Errorf(NoUserWhenBroadcastErrorMessage)
	}

	for _, user := range t.Users {
		user.NotificationChan <- notification
		// log
	}
	return nil
}
