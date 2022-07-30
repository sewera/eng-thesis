func (t *Tag) start() {
	if t.NotificationChan == nil {
		t.NotificationChan = make(chan Notification)
	}

	go func() {
		for {
			_ = t.broadcast(<-t.NotificationChan)
		}
	}()

	// log
}
