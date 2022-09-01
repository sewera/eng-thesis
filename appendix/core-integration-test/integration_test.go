func TestNotificationFlow(t *testing.T) {
	init := func() int {
		port, err := netutil.FindFreePort()
		if err != nil {
			panic("could not find free port")
		}
		initCore(t, port)
		return port
	}

	// given
	port := init()

	t.Run("push notification - notification is pushed to ws client", func(t *testing.T) {
		// given
		notification := appNotification
		pushNotificationTitle := "push notification"
		notification.Title = pushNotificationTitle

		producer := newAppProducer(t, port)

		userWSClient := newUserWSClient(t, port)
		userWSClient.connect()
		defer userWSClient.close()

		// when
		producer.pushNotification(notification)

		// then
		<-userWSClient.saved
		assertByTitle(t, pushNotificationTitle, userWSClient.notifications)
	})

	t.Run("get notifications - notification list is returned", func(t *testing.T) {
		// given
		notification := appNotification
		getNotificationsTitle := "get notifications"
		notification.Title = getNotificationsTitle

		producer := newAppProducer(t, port)

		userRestClient := newUserRestClient(t, port)

		// when
		producer.pushNotification(notification)
		userRestClient.getNotifications()

		// then
		assertByTitle(t, getNotificationsTitle, userRestClient.notifications)
	})
}
