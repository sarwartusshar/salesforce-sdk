public class IBMWatsonRequest {

  private final URL url;
  private final String method;
  private final Map<String, String> headers;
  private final IBMWatsonRequestBody body;

  private IBMWatsonRequest(Builder builder) {
    if (builder == null) {
      throw new IBMWatsonServiceExceptions.IllegalArgumentException('builder cannot be null');
    }

    this.url = builder.url;
    this.method = builder.method;
    this.headers = new Map<String, String>();
    this.headers.putAll(builder.headers);
    this.body = builder.body.clone();
  }

  public URL getUrl() {
    return this.url;
  }

  public String getMethod() {
    return this.method;
  }

  public Map<String, String> getAllHeaders() {
    return this.headers;
  }

  public String header(String name) {
    return headers.get(name);
  }

  public List<String> getHeadersByName(String name) {
    List<String> headerValues = new List<String>();
    if (headers != null && !headers.isEmpty()) {
      for (String headerName: headers.keySet()) {
        if (String.isNotBlank(headerName) && headerName.equalsIgnoreCase(name)) {
          headerValues.add(headers.get(headerName));
        }
      }
    }
    return headerValues;
  }

  public IBMWatsonRequestBody getBody() {
    return this.body;
  }

  public Builder newBuilder() {
    return new Builder(this);
  }

  public override String toString() {
    return 'Request{method=' + method + ', url=' + url + '}';
  }

  public class Builder {
    private URL url;
    private String method;
    private Map<String, String> headers;
    private IBMWatsonRequestBody body;

    public Builder() {
      this.method = 'GET';
      this.headers = new map<String, String>();
    }

    Builder(IBMWatsonRequest request) {
      this.url = request.url;
      this.method = request.method;
      this.body = request.body;
      this.headers = new Map<String, String>();
      this.headers.putAll(request.headers);
    }

    public Builder url(URL url) {
      if (url == null) {
        throw new IBMWatsonServiceExceptions.IllegalArgumentException('url == null');
      }

      this.url = url;
      return this;
    }

    /**
     * Sets the URL target of this request.
     *
     * @throws IllegalArgumentException if {@code url} is not a valid HTTP or HTTPS URL. Avoid this
     * exception by calling {@link HttpUrl#parse}; it returns null for invalid URLs.
     */
    public Builder url(String url) {
      if (url == null) {
        throw new IBMWatsonServiceExceptions.IllegalArgumentException('url == null');
      }

      URL parsed = new URL(url);
      if (parsed == null) {
        throw new IBMWatsonServiceExceptions.IllegalArgumentException('unexpected url: ' + url);
      }
      return url(parsed);
    }

    /**
     * Adds a header with {@code name} and {@code value}. Prefer this method for multiply-valued
     * headers like "Cookie".
     *
     * <p>Note that for some headers including {@code Content-Length} and {@code Content-Encoding},
     * OkHttp may replace {@code value} with a header derived from the request body.
     */
    public Builder addHeader(String name, String value) {
      headers.put(name, value);
      return this;
    }

    public Builder method(String method, IBMWatsonRequestBody body) {
      if (String.isBlank(method)) {
        throw new IBMWatsonServiceExceptions.IllegalArgumentException('method == empty');
      }
      this.method = method;
      this.body = body;
      return this;
    }

    public IBMWatsonRequest build() {
      if (url == null) {
        throw new IBMWatsonServiceExceptions.IllegalArgumentException('url == null');
      }
      return new IBMWatsonRequest(this);
    }
  }
}