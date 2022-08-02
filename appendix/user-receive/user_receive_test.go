t.Run("multiple receive - same notification", func(t *testing.T) {
	// given
	user, _ := NewTestUser()

	// when
	done := util.AsyncRun(func() {
		for i := 0; i < 5; i++ {
			user.Receive(notification)
		}
	})

	// then
	util.AsyncAssert(t, done).ElementsMatch(
		[]domain.Notification{notification},
		user.GetNotifications(0, user.GetNotificationCount()),
	)
})
