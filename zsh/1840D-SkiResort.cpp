#include <bits/stdc++.h>
using namespace std;

// --- Type Aliases ---
using ll = long long;
using ld = long double;
using pii = pair<int, int>;
using pll = pair<ll, ll>;
using vi = vector<int>;
using vll = vector<ll>;
using vpii = vector<pii>;
using vpll = vector<pll>;

// --- Macros ---
#define all(x) (x).begin(), (x).end()
#define rall(x) (x).rbegin(), (x).rend()
#define sz(x) static_cast<int>((x).size())
#define pb push_back
#define eb emplace_back

// --- Constants ---
constexpr int INF = 1e9 + 7;
constexpr ll INFLL = 1e18 + 7;
constexpr int MOD = 1e9 + 7; // Swap to 998244353 if needed

// --- Utility Templates ---
template<typename T> inline bool chmin(T &a, const T &b) { return b < a ? a = b, true : false; }
template<typename T> inline bool chmax(T &a, const T &b) { return a < b ? a = b, true : false; }

// --- Anti-Hash Collision (Prevents Codeforces O(N^2) Hacking) ---
struct custom_hash {
    static uint64_t splitmix64(uint64_t x) {
        x += 0x9e3779b97f4a7c15;
        x = (x ^ (x >> 30)) * 0xbf58476d1ce4e5b9;
        x = (x ^ (x >> 27)) * 0x94d049bb133111eb;
        return x ^ (x >> 31);
    }
    size_t operator()(uint64_t x) const {
        static const uint64_t FIXED_RANDOM = chrono::steady_clock::now().time_since_epoch().count();
        return splitmix64(x + FIXED_RANDOM);
    }
};

// --- Debugging Setup ---
#ifndef ONLINE_JUDGE
#define debug(x) cerr << #x << " = " << (x) << "\n"
#else
#define debug(x)
#endif

// --- Main Solution ---
void solve() {
    // Problem logic here
    
}

int main() {
    // Fast I/O setup
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);

    int t = 1;
    cin >> t; // Comment this out if problem has only 1 test case
    while (t--) {
        solve();
    }

    return 0;
}
