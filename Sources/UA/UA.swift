/// A user-agent string.
@frozen public
struct UA:Equatable, Hashable, Sendable
{
    public
    var components:[Component]

    @inlinable public
    init(components:[Component])
    {
        self.components = components
    }
}
extension UA:ExpressibleByArrayLiteral
{
    @inlinable public
    init(arrayLiteral:Component...)
    {
        self.init(components: arrayLiteral)
    }
}
extension UA:CustomStringConvertible
{
    public
    var description:String
    {
        var string:String = ""
        for component in self.components
        {
            if !string.isEmpty
            {
                string += " "
            }

            switch component
            {
            case .product(let product):
                string += "\(product)"

            case .comment(let clauses):
                string += "("
                string += clauses.joined(separator: "; ")
                string += ")"
            }
        }
        return string
    }
}
extension UA:LosslessStringConvertible
{
    public
    init(parsing description:String) throws
    {
        self.init(components: try HeaderRule.parse(description.utf8))
    }

    public
    init?(_ description:String)
    {
        do
        {
            self.init(components: try HeaderRule.parse(description.utf8))
        }
        catch
        {
            return nil
        }
    }

    public
    init?(_ description:Substring)
    {
        do
        {
            self.init(components: try HeaderRule.parse(description.utf8))
        }
        catch
        {
            return nil
        }
    }
}
