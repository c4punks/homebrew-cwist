class Cwist < Formula
  desc "C17 web framework and application server"
  homepage "https://github.com/c4punks/CWIST"
  url "https://github.com/c4punks/CWIST/releases/download/v4.2.4/cwist-4.2.4.tar.gz"
  sha256 "bba4c75b9bdf18edcdfa7379bd47544607fe8bcde36588a7f11cbd403896dd4b"
  license all_of: ["MIT", "Apache-2.0", "BSD-3-Clause", :public_domain]

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "brotli"
  depends_on "zstd"

  uses_from_macos "curl"
  uses_from_macos "zlib"

  def install
    system "make", "-j#{ENV.make_jobs}", "CWIST_SQLITE_FTS5=1", "VERSION=4.2.4"
    system "make", "install", "PREFIX=#{prefix}", "CWIST_SQLITE_FTS5=1", "VERSION=4.2.4"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <cwist/app.h>
      static void hello(cwist_http_request *req, cwist_http_response *res) {
          (void)req;
          cwist_sstring_assign(res->body, "ok");
      }
      int main(void) {
          cwist_app *app = cwist_app_create();
          cwist_app_get(app, "/", hello);
          cwist_app_destroy(app);
          return 0;
      }
    EOS
    flags = shell_output("pkg-config --cflags --libs cwist").split
    system ENV.cc, "-o", "test", "test.c", *flags
    system "./test"
  end
end
