"""Copyright 2015 Rafal Kowalski"""
import unittest
from tests.utils import OpenEventTestCase

from tests.setup_database import Setup
from tests.object_mother import ObjectMother
from open_event import current_app as app
from open_event.helpers.data import save_to_db


class TestSessionApi(OpenEventTestCase):

    def test_add_session_to_db(self):
        session = ObjectMother.get_session()
        with app.test_request_context():
            save_to_db(session, "Session saved")
            self.assertEqual(session.id, 1)

if __name__ == '__main__':
    unittest.main()
