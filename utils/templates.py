from jinja2 import Template

asm_event_template = Template(
    """
package flash.events
{
    {% if temp.imports != "" %}
    {{ temp.imports }}
    {% endif %}
    {{ temp.class_sig }} extends {{ temp.class_parent }}
    {
        {{ temp.class_constants }}

        {{ temp.class_properties }}

        {{ temp.con_def }}
        {
            super({{ temp.super_args }});
            {{ temp.con_body }}
        }
        {{ temp.methods }}
    }
}
"""
)


method_template = Template(
    """

        public function get {{ c.name }}() : {{ c.type }}
        {
            return this._{{ c.name }};
        }
        """
)
