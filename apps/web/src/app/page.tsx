export default function Home() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 dark:from-slate-900 dark:to-slate-800">
      <div className="container mx-auto px-4 py-16">
        <div className="text-center">
          <h1 className="text-4xl md:text-6xl font-bold text-slate-900 dark:text-white mb-6">
            Productivity Booster
          </h1>
          <p className="text-xl text-slate-600 dark:text-slate-300 mb-8 max-w-2xl mx-auto">
            AI-powered deep work application to help you achieve sustained, distraction-free focus
          </p>
          
          <div className="bg-white dark:bg-slate-800 rounded-lg shadow-lg p-8 max-w-md mx-auto">
            <h2 className="text-2xl font-semibold text-slate-800 dark:text-white mb-4">
              Platform Status
            </h2>
            <div className="space-y-3">
              <div className="flex items-center justify-between">
                <span className="text-slate-600 dark:text-slate-300">Web App</span>
                <span className="bg-green-100 text-green-800 px-2 py-1 rounded-full text-sm">
                  ✓ Running
                </span>
              </div>
              <div className="flex items-center justify-between">
                <span className="text-slate-600 dark:text-slate-300">Backend API</span>
                <span className="bg-green-100 text-green-800 px-2 py-1 rounded-full text-sm">
                  ✓ Running
                </span>
              </div>
              <div className="flex items-center justify-between">
                <span className="text-slate-600 dark:text-slate-300">Mobile App</span>
                <span className="bg-yellow-100 text-yellow-800 px-2 py-1 rounded-full text-sm">
                  ⏳ Pending
                </span>
              </div>
            </div>
          </div>

          <div className="mt-12 grid md:grid-cols-3 gap-6 max-w-4xl mx-auto">
            <div className="bg-white dark:bg-slate-800 p-6 rounded-lg shadow">
              <h3 className="text-lg font-semibold text-slate-800 dark:text-white mb-2">
                Cross-Platform
              </h3>
              <p className="text-slate-600 dark:text-slate-300 text-sm">
                Works on web browsers, Android devices, and iPad
              </p>
            </div>
            <div className="bg-white dark:bg-slate-800 p-6 rounded-lg shadow">
              <h3 className="text-lg font-semibold text-slate-800 dark:text-white mb-2">
                AI-Powered
              </h3>
              <p className="text-slate-600 dark:text-slate-300 text-sm">
                Intelligent task management and behavioral coaching
              </p>
            </div>
            <div className="bg-white dark:bg-slate-800 p-6 rounded-lg shadow">
              <h3 className="text-lg font-semibold text-slate-800 dark:text-white mb-2">
                Deep Work
              </h3>
              <p className="text-slate-600 dark:text-slate-300 text-sm">
                Based on Cal Newport&apos;s proven focus principles
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
