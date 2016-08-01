using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(SoporteTest1.Startup))]
namespace SoporteTest1
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
