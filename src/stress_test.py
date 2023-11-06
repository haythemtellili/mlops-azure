from locust import FastHttpUser, between, events, task
import random

def generate_random_json_data():
    # Define possible values for categorical features
    sex_values = ["male", "female"]
    education_values = ["university", "high_school", "graduate_school"]
    marriage_values = ["married", "single", "others"]
    repayment_status_values = ["duly_paid", "delay_2_months", "no_delay"]

    # Create a dictionary with random numerical values
    data = {
        "sex": random.choice(sex_values),
        "education": random.choice(education_values),
        "marriage": random.choice(marriage_values),
        "repayment_status_1": random.choice(repayment_status_values),
        "repayment_status_2": random.choice(repayment_status_values),
        "repayment_status_3": random.choice(repayment_status_values),
        "repayment_status_4": random.choice(repayment_status_values),
        "repayment_status_5": random.choice(repayment_status_values),
        "repayment_status_6": random.choice(repayment_status_values),
        "credit_limit": random.uniform(1000.0, 50000.0),
        "age": random.randint(18, 80),
        "bill_amount_1": random.uniform(0.0, 5000.0),
        "bill_amount_2": random.uniform(0.0, 5000.0),
        "bill_amount_3": random.uniform(0.0, 5000.0),
        "bill_amount_4": random.uniform(0.0, 5000.0),
        "bill_amount_5": random.uniform(0.0, 5000.0),
        "bill_amount_6": random.uniform(0.0, 5000.0),
        "payment_amount_1": random.uniform(0.0, 5000.0),
        "payment_amount_2": random.uniform(0.0, 5000.0),
        "payment_amount_3": random.uniform(0.0, 5000.0),
        "payment_amount_4": random.uniform(0.0, 5000.0),
        "payment_amount_5": random.uniform(0.0, 5000.0),
        "payment_amount_6": random.uniform(0.0, 5000.0),
    }

    # Create the JSON structure
    json_data = {"data": [data]}

    return json_data


@events.init_command_line_parser.add_listener
def _(parser):
    parser.add_argument("--aml-webservice-auth-key", include_in_web_ui=True, default="")


class User(FastHttpUser):
    # specifiy a wait time as needed. When commented out/removed = no wait time
    wait_time = between(1, 5)

    @task
    def test_api(self):
        self.client.post(
        "",
        json = generate_random_json_data(),
        headers={
            "Content-Type": "application/json",
            "Authorization": f"Bearer {self.environment.parsed_options.aml_webservice_auth_key}",
        },
        )
# To run the Locust load test, execute the following command:
# locust -f stress_test.py
