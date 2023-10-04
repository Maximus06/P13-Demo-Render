from django.test import TestCase, Client
from django.urls import reverse


class IndexTest(TestCase):
    def test_index_is_ok(self):
        c = Client()
        uri = reverse("index")
        response = c.get(uri)
        self.assertEqual(response.status_code, 200)
