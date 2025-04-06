# Instructions for Reproducing OWASP Top 10 2021 Vulnerabilities in a Rails Application

## A01:2021 - Broken Access Control

### 1. Testing IDOR (Insecure Direct Object Reference)

1. Log in as a regular user (username: user, password: user123)
2. Note the URL after logging in.
3. Change the URL to  `/users/1` or other user_id parameter.
4. You will gain access to another user's information without proper authorization.

### 2. Testing Missing Access Control for Articles

1. Log in as a regular user (username: user, password: user123).
2. Navigate to an article created by the administrator.
3. Click on the "Edit" link.
4. Modify the article content and click "Update article".
5. The article will be updated even though you are not the author.

## A02:2021 - Cryptographic Failures

1. Open your browser's developer tools (F12).
2. Navigate to the "Network" tab.
3. Log in to the system.
4. Find the request to `/login` and inspect the form data.
5. You will see that passwords are transmitted in plaintext.

## A03:2021 - Injection

### 1. Testing SQL Injection

1. Navigate to the articles page.
2. In the search field, enter: `'; DROP TABLE users; --`
3. The table will not be dropped due to Rails' built-in protections, but try:
4. `' OR '1'='1`
5. You will see all articles instead of the filtered results.

### 2. Testing XSS (Cross-Site Scripting)

1. Create a new comment on an article.
2. In the content field, enter: `<script>alert('XSS');</script>`
3. After saving the comment, the JavaScript code will execute in your browser.

## A04:2021 - Insecure Design

### 1. Testing Lack of Request Rate Limiting

1. Open your browser's developer console.
2. Write a script to execute many requests simultaneously:
```
for (let i = 0; i < 1000; i++) {
  fetch('/proxy', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      url: '[https://example.com](https://example.com)'
    })
  });
}
```
3. Execute the script in the console - the server will be overloaded due to the absence of request limits.

## A05:2021 - Security Misconfiguration

Checking for Verbose Error Messages

1. Enter an intentionally incorrect URL, for example: `/articles/99999`.
2. You will see a detailed error message with a stack trace instead of a generic error page.

## A06:2021 - Vulnerable and Outdated Components

### 1. Checking Component Versions

1. Review the `Gemfile.lock` file in the project root.
2. Use a tool to check for vulnerabilities in dependencies:
```
bundle-audit check --update
```
3. The tool will display known vulnerabilities in the used gems.

## A07:2021 - Identification and Authentication Failures

### 1. Checking for Weak Password Recovery Mechanism

1. Navigate to the "Forgot your password?" link.
2. Enter the username "admin".
3. For the security question, try common answers like "London", "New York", "Paris".
4. The system should allow password reset with a minimal number of attempts.

### 2. Checking for Lack of Brute-Force Protection

1. Use a script to automatically try common passwords:
```
for password in $(cat common_passwords.txt); do
  curl -X POST -d "username=admin&password=$password" http://localhost:3000/login
done
```
2. The absence of rate limiting will allow for brute-forcing many passwords.

## A08:2021 - Software and Data Integrity Failures

### 1. Checking for Insecure Deserialization

1. Create a malicious object for deserialization:
```
# Creating a malicious object
class Exploit
  def initialize(cmd)
    @cmd = cmd
  end

  def marshal_dump
    # Code that will be executed upon deserialization
    eval(@cmd)
  end

  def marshal_load(data)
  end
end

payload = Marshal.dump(Exploit.new('`ls -la`'))
encoded_payload = Base64.encode64(payload)
puts encoded_payload
```
2. Send this encoded string in a request to `/file_uploads/import_data`.
3. You will observe that the code is executed on the server during deserialization.

## A09:2021 - Security Logging and Monitoring Failures

1. Attempt several failed login attempts.
2. Check the server logs (`log/development.log`).
3. Notice that failed authentication attempts are not logged properly.
4. Similarly, try accessing a non-existent resource or page and check the logs.

## A10:2021 - Server-Side Request Forgery (SSRF)

### 1. Checking for SSRF Vulnerability

1. Navigate to the `/proxy` page.
2. In the URL field, enter a link to an internal resource, for example: `http://localhost:3000/users`.
3. The application will provide access to this resource through the backend.
4. Also try: `file:///etc/passwd` or `http://localhost:8080/` (if you have other services running).
5. The application will allow access to internal resources.